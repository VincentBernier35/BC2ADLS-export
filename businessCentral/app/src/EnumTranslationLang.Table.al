table 82568 "ADLSE Enum Translation Lang"
{
    DataClassification = ToBeClassified;
    Caption = 'ADLSE Enum Translation Language';
    Access = Internal;
    Permissions = tabledata "ADLSE Enum Translation Lang" = RI;
    LookupPageId = "ADLSE Enum Translations Lang";
    DrillDownPageId = "ADLSE Enum Translations Lang";

    fields
    {
        field(1; "Language Code"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Language Code';
            ToolTip = 'The language code.';
        }
        field(2; "Table Id"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Table Id';
            AllowInCustomizations = Always;
        }
        field(3; "Compliant Table Name"; Text[40])
        {
            DataClassification = SystemMetadata;
            Caption = 'Compliant Table Name';
            ToolTip = 'The name of the field that is compliant with Data Lake standards.';
        }
        field(4; "Field Id"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Field Id';
            AllowInCustomizations = Always;
        }
        field(5; "Compliant Field Name"; Text[40])
        {
            DataClassification = SystemMetadata;
            Caption = 'Compliant Object Name';
            ToolTip = 'The name of the field that is compliant with Data Lake standards.';
        }
        field(6; "Enum Value Id"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Enum Index';
            AllowInCustomizations = Always;
        }
        field(7; "Enum Value Caption"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Enum Caption';
            ToolTip = 'The caption of the enum value.';
        }
    }

    keys
    {
        key(Key1; "Language Code", "Table Id", "Field Id", "Enum Value Id")
        {
            Clustered = true;
        }
    }

    procedure InsertEnumLanguage(LanguageCode: Code[10]; TableId: Integer; FieldNo: Integer; FieldName: Text[30]; EnumValueOrdinal: Integer; EnumValueName: Text)
    var
        ADLSEUtil: Codeunit "ADLSE Util";
    begin
        Rec.Init();
        Rec."Language Code" := LanguageCode;
        Rec."Table Id" := TableId;
        Rec."Compliant Table Name" := CopyStr(ADLSEUtil.GetDataLakeCompliantTableName(TableId), 1, MaxStrLen((Rec."Compliant Table Name")));
        Rec."Field Id" := FieldNo;
        Rec."Compliant Field Name" := CopyStr(ADLSEUtil.GetDataLakeCompliantFieldName(FieldName, FieldNo), 1, MaxStrLen((Rec."Compliant Field Name")));
        Rec."Enum Value Id" := EnumValueOrdinal;
        Rec."Enum Value Caption" := CopyStr(EnumValueName, 1, MaxStrLen(Rec."Enum Value Caption"));
        Rec.Insert(true);
    end;
}