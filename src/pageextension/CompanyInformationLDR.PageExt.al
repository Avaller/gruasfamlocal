/// <summary>
/// PageExtension CompanyInformation_LDR (ID 50000) extends Record Company Information.
/// </summary>
pageextension 50000 "CompanyInformation_LDR" extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("Footer Picture"; Rec."Footer Picture_LDR")
            {
                ApplicationArea = All;
                Caption = 'Imagen Pie de Página';
                ToolTip = 'Especifica Imagen Pie de Página';
            }
            field("Company Registry Text"; Rec."Company Registry Text_LDR")
            {
                ApplicationArea = All;
                Caption = 'Texto Registro Mercantil';
                ToolTip = 'Especifica Texto Registro Mercantil';
            }
        }
        addafter("Home Page")
        {
            field("Distributor Short Name"; Rec."Distributor Short Name_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nombre Concesionario Abreviado';
                ToolTip = 'Especifica Nombre Concesionario Abreviado';
            }
        }
        addafter("IC Inbox Details")
        {
            group("Params Ingestrel")
            {
                Caption = 'Parametros Ingestrel';

                field("Export Ingestrel_LDR"; Rec."Export Ingestrel_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Exportar a Ingestrel';
                    ToolTip = 'Exportar a Ingestrel';
                }

                field("Company ID_LDR"; Rec."Company ID_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'ID de Compañia';
                    ToolTip = 'ID de Compañia';
                }

                field("VAT Registration No._LDR"; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de registro de IVA';
                    ToolTip = 'Número de registro de IVA';
                }
                field("Name_LDR"; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    ToolTip = 'Nombre';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    ToolTip = 'Nombre';
                }
                field("Address_LDR"; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Dirección';
                    ToolTip = 'Dirección';
                }
                field("Address 2_LDR"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección';
                    ToolTip = 'Dirección';
                }
                field("City_LDR"; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad';
                    ToolTip = 'Ciudad';
                }
                field("Post Code_LDR"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código postal';
                    ToolTip = 'Código postal';
                }
                field("County_LDR"; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'Condado';
                    ToolTip = 'Condado';
                }
                field("Country/Region Code_LDR"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de país/región';
                    ToolTip = 'Código de país/región';
                }
                field("Phone No._LDR"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'N.° de teléfono';
                    ToolTip = 'N.° de teléfono';
                }
                field("Export Date_LDR"; Rec."Export Date_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de exportación';
                    ToolTip = 'Fecha de exportación';
                }
                field("Logo"; Rec.Logo_LDR)
                {
                    ApplicationArea = All;
                    Caption = 'Logo';
                    ToolTip = 'Logo';
                }
                field("Manager Name_LDR"; Rec."Manager Name_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del gerente';
                    ToolTip = 'Nombre del gerente';
                }
                field("Manager Cif_LDR"; Rec."Manager Cif_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Gerente Cif';
                    ToolTip = 'Gerente Cif';
                }
                field("Risks Name_LDR"; Rec."Risks Name_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de los riesgos';
                    ToolTip = 'Nombre de los riesgos';
                }
                field("Risks Cif_LDR"; Rec."Risks Cif_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Administrador de firmas';
                    ToolTip = 'Administrador de firmas';
                }
                field("Signature Manager_LDR"; Rec."Signature Manager_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Administrador de firmas';
                    ToolTip = 'Administrador de firmas';
                }
                field("Signature Risks_LDR"; Rec."Signature Risks_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Riesgos de firma';
                    ToolTip = 'Riesgos de firma';
                }
                field("Signature Committe_LDR"; Rec."Signature Committe_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Comité de Firmas';
                    ToolTip = 'Comité de Firmas';
                }
                field("Colour_LDR"; Rec.Colour_LDR)
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    ToolTip = 'Color';
                }
            }
        }
    }
}