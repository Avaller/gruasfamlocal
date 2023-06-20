/// <summary>
/// tableextension 50108 "Service Item Group_LDR"
/// </summary>
tableextension 50108 "Service Item Group_LDR" extends "Service Item Group"
{
    trigger OnAfterDelete()
    var
    //Plantillas: Record 7121997;
    begin
        //Clear(Plantillas);
        //Plantillas.SetRange(Plantillas."Service Item Group Code", Code);
        //Plantillas.DeleteAll(true);
    end;
}