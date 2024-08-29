// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License. See LICENSE in the project root for license information.
permissionset 82561 "ADLSE - Execute"
{
    /// <summary>
    /// The permission set to be used when running the Azure Data Lake Storage export tool.
    /// </summary>
    Access = Public;
    Assignable = true;
    Caption = 'ADLSE - Execute', Locked = true;

    Permissions =
                tabledata "ADLSE Setup" = RM,
                tabledata "ADLSE Table" = RM,
                tabledata "ADLSE Field" = R,
                tabledata "ADLSE Deleted Record" = R,
                tabledata "ADLSE Current Session" = RIMD,
                tabledata "ADLSE Table Last Timestamp" = RIMD,
                tabledata "ADLSE Run" = RIMD,
                tabledata "ADLSE Enum Translation" = RIMD,
                tabledata "ADLSE Enum Translation Lang" = RIMD,
                // ci-dessous ajout VBE
                codeunit "ADLSE CDM Util" = X,
                codeunit ADLSE = X,
                codeunit "ADLSE Execute" = X,
                codeunit "ADLSE Execution" = X,
                codeunit "ADLSE External Events" = X,
                xmlport "BC2ADLS Export" = X,
                xmlport "BC2ADLS Import" = X,
                codeunit "ADLSE Clear Tracked Deletions" = X,
                codeunit "ADLSE Communication" = X,
                codeunit "ADLSE Credentials" = X,
                codeunit "ADLSE Gen 2 Util" = X,
                codeunit "ADLSE Http" = X,
                codeunit "ADLSE Installer" = X,
                codeunit "ADLSE Util" = X,
                codeunit "ADLSE Upgrade" = X,
                codeunit "ADLSE Setup" = X,
                codeunit "ADLSE Session Manager" = X,
                codeunit "ADLSE UpgradeTagNewCompanySubs" = X,
                codeunit "ADLSE External Events Helper" = X,
                page "ADLSE CurrentSession API" = X,
                page "ADLSE Enum Translations Lang" = X,
                page "ADLSE Enum Translations" = X,
                page "ADLSE Table API" = X,
                page "ADLSE Setup Tables" = X,
                page "ADLSE Setup Fields" = X,
                page "ADLSE Setup" = X,
                page "ADLSE Run" = X,
                page "ADLSE Setup API v11" = X,
                page "ADLSE Setup API" = X,
                page "ADLSE Run API" = X,
                page "ADLSE Field API" = X,
                report "ADLSE Seek Data" = X,
                table "ADLSE Run" = X,
                table "ADLSE Current Session" = X,
                table "ADLSE Deleted Record" = X,
                table "ADLSE Table" = X,
                table "ADLSE Field" = X,
                table "ADLSE Setup" = X,
                table "ADLSE Enum Translation Lang" = X,
                table "ADLSE Enum Translation" = X;

}