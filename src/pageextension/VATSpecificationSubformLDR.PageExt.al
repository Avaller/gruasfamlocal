/// <summary>
/// PageExtension VAT Specification Subform (ID 50084) extends Record VAT Specification Subform.
/// </summary>
pageextension 50087 "VAT Specification Subform" extends "VAT Specification Subform"
{
    /// <summary>
    /// SetPostedServHeader.
    /// </summary>
    /// <param name="PostedServiceHeader">Record "Posted Service Header_LDR".</param>
    procedure SetPostedServHeader(PostedServiceHeader: Record "Posted Service Header_LDR")
    begin
        PostedServHeader := PostedServiceHeader;
    end;

    var
        PostedServHeader: Record "Posted Service Header_LDR";
}