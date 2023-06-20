/// <summary>
/// tableextension 50105 "Customer Bank Account_LDR"
/// </summary>
tableextension 50105 "Customer Bank Account_LDR" extends "Customer Bank Account"
{
    fields
    {
        modify("CCC Bank No.")
        {
            trigger OnAfterValidate()
            begin
                if ("CCC Control Digits" <> '') and ("CCC Bank No." <> '') and ("CCC Bank Account No." <> '') and ("CCC Bank Branch No." <> '') then begin
                    Clear(DigitoControl);
                    DigitoControl.CheckControlDigit("CCC Control Digits", "CCC Bank No.", "CCC Bank Account No.", "CCC Bank Branch No.");
                end;
            end;
        }

        modify("CCC Bank Branch No.")
        {
            trigger OnAfterValidate()
            begin
                if ("CCC Control Digits" <> '') and ("CCC Bank No." <> '') and ("CCC Bank Account No." <> '') and ("CCC Bank Branch No." <> '') then begin
                    Clear(DigitoControl);
                    DigitoControl.CheckControlDigit("CCC Control Digits", "CCC Bank No.", "CCC Bank Account No.", "CCC Bank Branch No.");
                end;
            end;
        }

        modify("CCC Control Digits")
        {
            trigger OnAfterValidate()
            begin
                if ("CCC Control Digits" <> '') and ("CCC Bank No." <> '') and ("CCC Bank Account No." <> '') and ("CCC Bank Branch No." <> '') then begin
                    Clear(DigitoControl);
                    DigitoControl.CheckControlDigit("CCC Control Digits", "CCC Bank No.", "CCC Bank Account No.", "CCC Bank Branch No.");
                end;
            end;
        }

        modify("CCC Bank Account No.")
        {
            trigger OnAfterValidate()
            begin
                if ("CCC Control Digits" <> '') and ("CCC Bank No." <> '') and ("CCC Bank Account No." <> '') and ("CCC Bank Branch No." <> '') then begin
                    Clear(DigitoControl);
                    DigitoControl.CheckControlDigit("CCC Control Digits", "CCC Bank No.", "CCC Bank Account No.", "CCC Bank Branch No.");
                end;
            end;
        }

        modify("CCC No.")
        {
            trigger OnAfterValidate()
            begin
                if ("CCC Control Digits" <> '') and ("CCC Bank No." <> '') and ("CCC Bank Account No." <> '') and ("CCC Bank Branch No." <> '') then begin
                    Clear(DigitoControl);
                    DigitoControl.CheckControlDigit("CCC Control Digits", "CCC Bank No.", "CCC Bank Account No.", "CCC Bank Branch No.");
                end;
            end;
        }
    }

    var
        DigitoControl: Codeunit "Document-Misc";
}