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
                page "ADLSE CurrentSession API" = X,
                page "ADLSE Enum Translations Lang" = X,
                page "ADLSE Enum Translations" = X,
                page "ADLSE Field API" = X;


}