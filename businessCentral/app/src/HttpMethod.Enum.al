// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License. See LICENSE in the project root for license information.
enum 82561 "ADLSE Http Method"
{
    Access = Internal;
    Extensible = false;

    value(1; Get)
    {
        Caption = 'HTTP GET Method';
    }
    value(2; Put)
    {
        Caption = 'HTTP PUT Method';
    }
    value(3; Delete)
    {
        Caption = 'HTTP DELETE Method';
    }
    value(4; Patch)
    {
        Caption = 'HTTP PATCH Method';
    }
    value(5; Head)
    {
        Caption = 'HTTP HEAD Method';
    }
}
