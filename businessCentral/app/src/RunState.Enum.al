// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License. See LICENSE in the project root for license information.
enum 82560 "ADLSE Run State"
{
    Access = Internal;
    Extensible = false;

    value(1; None)
    {
        Caption = 'Never run';
    }

    value(2; InProcess)
    {
        Caption = 'In process';
    }

    value(3; Success)
    {
        Caption = 'Success';
    }

    value(4; Failed)
    {
        Caption = 'Failed';
    }
}