/// <summary>
/// tableextension 50064 "Warehouse Setup_LDR"
/// </summary>
tableextension 50064 "Warehouse Setup_LDR" extends "Warehouse Setup"
{
    fields
    {
        field(50000; "Folder Log File_LDR"; Text[250])
        {
            Caption = 'Ruta Fichero Log';
            DataClassification = ToBeClassified;
        }
    }
}