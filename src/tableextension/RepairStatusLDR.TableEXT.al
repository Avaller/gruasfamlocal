/// <summary>
/// tableextension 50072 "Repair Status_LDR"
/// </summary>
tableextension 50072 "Repair Status_LDR" extends "Repair Status"
{
    fields
    {
        field(50001; Shipped_LDR; BoolEAN)
        {
            Caption = 'Enviado';
            DataClassification = ToBeClassified;
        }
        field(50002; "Serv. Order Replication Status_LDR"; BoolEAN)
        {
            Caption = 'Estado Para Replicación de Pedidos de Servicio';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                RepairStatus2: Record "Repair Status";
            begin
                if "Serv. Order Replication Status_LDR" = true then begin
                    RepairStatus2.SetFilter(Code, '<>%1', Code);
                    RepairStatus2.SetRange("Serv. Order Replication Status_LDR", true);
                    if RepairStatus2.FindFirst() then
                        RepairStatus2.ModifyAll("Serv. Order Replication Status_LDR", false);
                end;
            end;
        }
        field(50003; "Mobile Index_LDR"; Integer)
        {
            Caption = 'Índice Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50004; "Not allow insert service lines_LDR"; BoolEAN)
        {
            Caption = 'No Permitir Insertar Nuevas Líneas de Servicio';
            DataClassification = ToBeClassified;
        }
        field(50005; "Index of AMPLUS_LDR"; Integer)
        {
            Caption = 'Índice AMPLUS';
            DataClassification = ToBeClassified;
        }
        field(50006; "Planner Color_LDR"; Text[20])
        {
            Caption = 'Color Planificador';
            DataClassification = ToBeClassified;
        }
    }
}