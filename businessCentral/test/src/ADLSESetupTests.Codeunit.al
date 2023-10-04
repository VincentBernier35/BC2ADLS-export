codeunit 85565 "ADLSE Setup Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;
    trigger OnRun()
    begin
        // [FEATURE] bc2adls Setup
    end;

    var
        ADLSESetup: Record "ADLSE Setup";
        ADLSETable: Record "ADLSE Table";
        ADLSEField: Record "ADLSE Field";
        ADLSLibrarybc2adls: Codeunit "ADLSE Library - bc2adls";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryRandom: Codeunit "Library - Random";
        Assert: Codeunit Assert;
        "Storage Type": Enum "ADLSE Storage Type";
        IsInitialized: Boolean;

    [Test]
    procedure TestCorrectNameContainer()
    var
        ContainerName: Text;
    begin
        // [SCENARIO 101] Test Field Container with to short name
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");
        // [GIVEN]
        ContainerName := LibraryUtility.GenerateRandomNumericText(LibraryRandom.RandIntInRange(3, 63));

        // [WHEN] Container name is set to "TestContainer"
        ADLSESetup.Validate("Container", ContainerName);

        // [THEN] An error is thrown
        Assert.AreEqual(ADLSESetup.Container, ContainerName, 'Container names are not equal.');
    end;

    [Test]
    procedure TestCorrectNameContainerWithCapitals()
    var
        ContainerNameIncorrectFormatErr: Label 'The container name is in an incorrect format.';
    begin
        // [SCENARIO 102] Test Field Container with capitals
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");

        // [WHEN] Container name is set to "TestContainer"
        asserterror ADLSESetup.Validate("Container", 'TestContainer');

        // [THEN] An error is thrown
        Assert.ExpectedError(ContainerNameIncorrectFormatErr);
    end;

    [Test]
    procedure TestCorrectNameContainerWithMultipleDashesTogether()
    var
        ContainerNameIncorrectFormatErr: Label 'The container name is in an incorrect format.';
    begin
        // [SCENARIO 103] Test Field Container with multiple dashes together
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");

        // [WHEN] Container name is set to "TestContainer"
        asserterror ADLSESetup.Validate("Container", 'Test--Container');

        // [THEN] An error is thrown
        Assert.ExpectedError(ContainerNameIncorrectFormatErr);
    end;

    [Test]
    procedure TestCorrectNameContainerWithToLong()
    begin
        // [SCENARIO 104] Test Field Container with to long name
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");

        // [WHEN] Container name is set to "TestContainer"
        asserterror ADLSESetup.Validate("Container", LibraryUtility.GenerateRandomNumericText(70));

        // [THEN] An error is thrown
        Assert.ExpectedError('The length of the string is 70, but it must be less than or equal to 63 characters.');
    end;

    [Test]
    procedure TestCorrectNameContainerWithToShort()
    var
        ContainerNameIncorrectFormatErr: Label 'The container name is in an incorrect format.';
    begin
        // [SCENARIO 105] Test Field Container with to short name
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");

        // [WHEN] Container name is set to "TestContainer"
        asserterror ADLSESetup.Validate("Container", LibraryUtility.GenerateRandomNumericText(2));

        // [THEN] An error is thrown
        Assert.ExpectedError(ContainerNameIncorrectFormatErr);
    end;

    [Test]
    procedure InsertTableForExport()
    var
        InsertedTable: Integer;
    begin
        // [SCENARIO 106] Add a table for export
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");

        // [WHEN] Insert a table for export
        InsertedTable := ADLSLibrarybc2adls.InsertTable();
        ADLSETable := ADLSLibrarybc2adls.GetRandomTable();

        // [THEN] Check if the table is inserted
        Assert.AreEqual(ADLSETable."Table ID", InsertedTable, 'Tables are not equal');
    end;

    [Test]
    procedure InsertFieldForExport()
    var
        InsertedTable: Integer;
        FieldId: Integer;
    begin
        // [SCENARIO 107] Add a field for export of an excisting table
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");
        // [GIVEN] Insert a table for export
        InsertedTable := ADLSLibrarybc2adls.InsertTable();
        ADLSETable.Get(InsertedTable);
        ADLSLibrarybc2adls.InsertFields();
        FieldId := ADLSLibrarybc2adls.GetRandomField(ADLSETable);

        // [WHEN] A field is enabled for export
        ADLSLibrarybc2adls.EnableField(InsertedTable, FieldId);

        // [THEN] Check if the field is enabled
        ADLSEField.Get(InsertedTable, FieldId);
        Assert.AreEqual(ADLSETable."Table ID", InsertedTable, 'Tables are not equal');
        Assert.AreEqual(ADLSEField."Field ID", FieldId, 'Fields are not equal');
    end;

    [Test]
    [HandlerFunctions('ModalPageHandlerScheduleaJob,MessageHandler')]
    procedure ScheduleAnExportforJobQueue()
    var
        JobQueueEntry: Record "Job Queue Entry";
        ADLSEExecution: Codeunit "ADLSE Execution";
        JobScheduledTxt: Label 'The job has been scheduled. Please go to the Job Queue Entries page to locate it and make further changes.';
    begin
        // [SCENARIO 108] Schedule an export for the Job Queue
        // [GIVEN] Initialized test environment
        Initialize();
        ADLSLibrarybc2adls.CleanUp();
        // [GIVEN] Setup bc2adls table for Azure Blob Storage
        ADLSLibrarybc2adls.CreateAdlseSetup("Storage Type"::"Azure Data Lake");

        // [WHEN] Schedule an export for the Job Queue is triggerd
        ADLSEExecution.ScheduleExport();

        // [THEN] Check if the export is scheduled
        if JobQueueEntry.FindJobQueueEntry(JobQueueEntry."Object Type to Run"::Codeunit, Codeunit::"ADLSE Execution") then
            Assert.IsTrue(JobQueueEntry."Object Type to Run" = Codeunit::"ADLSE Execution", 'Job Queue Entry is not created');
    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";

    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"ADLSE Field API Tests");

        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"ADLSE Field API Tests");

        IsInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"ADLSE Field API Tests");
    end;

    [ModalPageHandler]
    procedure ModalPageHandlerScheduleaJob(var ScheduleaJob: Page "Schedule a Job"; var Response: Action)
    begin
        Response := Response::OK;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024])
    begin

    end;

}