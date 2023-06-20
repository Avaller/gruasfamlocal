/// <summary>
/// tableextension 50103 "Sales Shipment Header_LDR"
/// </summary>
tableextension 50103 "Sales Shipment Header_LDR" extends "Sales Shipment Header"
{
    procedure PrintRecordsValued(ShowRequestForm: BoolEAN);
    var
        ReportSelection: Record "Report Selections";
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        with SalesShptHeader do begin
            Copy(Rec);
            ReportSelection.SetRange(Usage, ReportSelection.Usage::"S.Shipment");
            ReportSelection.SetFilter("Report ID", '<>0');
            ReportSelection.Find('-');
            repeat
                Report.RunModal(ReportSelection."Report ID", ShowRequestForm, false, SalesShptHeader);
            until ReportSelection.Next() = 0;
        end;
    end;
}