/// <summary>
/// OnAction.
/// </summary>
pageextension 50083 "Acc.ScheduleOverview_LDR" extends "Acc. Schedule Overview"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("F&unctions")
        {
            action(ExportAnalysisToExcel)
            {
                ApplicationArea = All;
                Caption = 'Exportar a Excel Analitica';

                trigger OnAction()
                var
                    //ExportAnalisis: Report 7122106; //TODO: Report no encontrado
                    txtErrorPlantilla: Label 'Especifique %1 en %2';
                begin
                    GLSetup.GET;
                    GLSetup.TESTFIELD(GLSetup."Analytical Schedule Name_LDR");
                    IF NewCurrentSchedName <> GLSetup."Analytical Schedule Name_LDR" THEN
                        ERROR(TextAnalytical, GLSetup."Analytical Schedule Name_LDR");

                    GLSetup.CALCFIELDS(GLSetup."Analytical Excel Template_LDR");
                    IF NOT GLSetup."Analytical Excel Template_LDR".HASVALUE THEN
                        ERROR(txtErrorPlantilla, GLSetup.FIELDNAME("Analytical Excel Template_LDR"),
                                                GLSetup.TABLENAME);

                    //ExportAnalisis.SetOptions(Rec, CurrentColumnName, UseAmtsInAddCurr);
                    //ExportAnalisis.RUN;
                end;
            }
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        TextAnalytical: Label 'Seleccione el esquema de cuentas %1 para exportar la analitica';
}