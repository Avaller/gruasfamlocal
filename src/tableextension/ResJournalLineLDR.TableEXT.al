/// <summary>
/// tableextension 50037 "Res. Journal Line_LDR"
/// </summary>
tableextension 50037 "Res. Journal Line_LDR" extends "Res. Journal Line"
{
    fields
    {
        field(50000; Replicated_LDR; Boolean)
        {
            Caption = 'Replicado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "End Time_LDR" <> 0T then begin
                    if "End Time_LDR" < "Initial Time_LDR" then
                        Error(TxtHoraInicio);
                    Validate(Quantity, ("End Time_LDR" - "Initial Time_LDR") / 3600000);
                    Validate("Internal Quantity_LDR", ("End Time_LDR" - "Initial Time_LDR") / 3600000);
                end;
            end;
        }
        field(50002; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Initial Time_LDR" <> 0T then begin
                    if "End Time_LDR" < "Initial Time_LDR" then
                        Error(txtHoraFin);
                    Validate(Quantity, ("End Time_LDR" - "Initial Time_LDR") / 3600000);
                    Validate("Internal Quantity_LDR", ("End Time_LDR" - "Initial Time_LDR") / 3600000);
                end;
            end;
        }
        field(50003; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teóricaa';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        TxtHoraInicio: TextConst ENU = 'Starting Time is bigger than End Time', ESP = 'La hora de Inicio es mayor que la hora de Fin.';
        txtHoraFin: TextConst ENU = 'End Time is lower than Starting Time', ESP = 'La hora de Fin es menor que la hora de Inicio.';
}