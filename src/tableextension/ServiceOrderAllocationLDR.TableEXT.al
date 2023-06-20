/// <summary>
/// tableextension 50075 "Service Order Allocation_LDR"
/// </summary>
tableextension 50075 "Service Order Allocation_LDR" extends "Service Order Allocation"
{
    fields
    {
        field(50001; "Exported to Device_LDR"; BoolEAN)
        {
            Caption = 'Exportado a Dispositivo';
            DataClassification = ToBeClassified;
        }
        field(50002; "Resource Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text 
        {
            CalcFormula = Lookup("Resource"."Name" WHERE("No." = FIELD("Resource No.")));
            Caption = 'Nombre Recurso';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50003; Responsible_LDR; BoolEAN)
        {
            Caption = 'Responsable';
            DataClassification = ToBeClassified;
        }
        field(50004; "Assignation Priority_LDR"; Integer)
        {
            Caption = 'Prioridad Asignación';
            DataClassification = ToBeClassified;
        }
        field(50005; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50006; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50007; "Order Date_LDR"; Date)
        {
            CalcFormula = Lookup("Service Header"."Order Date" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Fecha Pedido';
            FieldClass = FlowField;
        }
    }
}