report 50024 "Crane Report by Offer"
{
    // version ACICATECH

    // 11/01/18 RGBLANCO RQ18.0041.R1 - Informe de PS por oferta
    // Se realiza un informe que lista por cada una de las ofertas de grua, todos los pedidos de servicio y pedidos de servicio historico.
    DefaultLayout = RDLC;
    RDLCLayout = './Crane Report by Offer.rdlc';

    CaptionML = ENU = 'Crane Report by Offer',
                ESP = 'Relación de Partes por Oferta';

    /*
    dataset
    {
        dataitem(DataItem1000000000; 50020)
        {
            column(QuoteNo; "Quote no.")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(Description; Description)
            {
            }
            column(ShipToAddressCode; "Ship-to Address Code")
            {
            }
            column(ShipToAddressName; "Ship-to Address Name")
            {
            }
            column(QuoteType; "Crane Service Quote Header"."Quote Type")
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    dataitem(DataItem1000000006; Table50022)
                    {
                        DataItemLink = Quote No.=FIELD(Quote no.);
                        DataItemLinkReference = "Crane Service Quote Header";
                        RequestFilterFields = "Quote No.";
                        column(OperationNo; "Operation No.")
                        {
                        }
                        column(OperationDescription; "Operation Description")
                        {
                        }
                        column(LineNo; "Line No.")
                        {
                        }
                        column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                        {
                        }
                        column(ServiceInvoiceCopytxt; CopyText)
                        {
                        }
                        column(OutputNo; OutputNo)
                        {
                        }
                        column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                        {
                        }
                        column(USERID; USERID)
                        {
                        }
                        column(CompanyLbl; CompanyLbl)
                        {
                        }
                        column(Tittle; Tittle)
                        {
                        }
                        column(CustomerLbl; CustomerLbl)
                        {
                        }
                        column(WorkLbl; WorkLbl)
                        {
                        }
                        column(OfferLbl; OfferLbl)
                        {
                        }
                        column(OperationLbl; OperationLbl)
                        {
                        }
                        column(DateLbl; DateLbl)
                        {
                        }
                        column(PartLbl; PartLbl)
                        {
                        }
                        column(QuoteTypelbl; QuoteTypelbl)
                        {
                        }
                        column(InvGroupLbl; InvGroupLbl)
                        {
                        }
                        column(VehicleLbl; VehicleLbl)
                        {
                        }
                        column(ResourceLbl; ResourceLbl)
                        {
                        }
                        column(ImpVehLbl; ImpVehLbl)
                        {
                        }
                        column(HoursLbl; HoursLbl)
                        {
                        }
                        column(AssistantLbl; AssistantLbl)
                        {
                        }
                        column(KmsLbl; KmsLbl)
                        {
                        }
                        column(TotalOperationLbl; TotalOperationLbl)
                        {
                        }
                        column(TotalGeneralLbl; TotalGeneralLbl)
                        {
                        }
                        column(LineNoLbl; LineNoLbl)
                        {
                        }
                        column(ImpVehExclVATLbl; ImpVehExclVATLbl)
                        {
                        }
                        dataitem(DataItem1000000016; Table5900)
                        {
                            DataItemLink = Crane Service Quote No.=FIELD(Quote No.),
                                           Crane Serv. Quote Op. Line No=FIELD(Line No.);
                            DataItemLinkReference = "Crane Service Quote Op. Line";
                            RequestFilterFields = "Document Type","No.","Order Date";
                            column(ServiceHeader_No;"No.")
                            {
                            }
                            column(ServiceHeader_OrderDate;"Order Date")
                            {
                            }
                            column(ServiceHeader_CraneServQuoteOpLineNo;"Crane Serv. Quote Op. Line No")
                            {
                            }
                            column(ServiceHeader_CraneServiceQuoteNo;"Crane Service Quote No.")
                            {
                            }
                            dataitem(DataItem1000000022;Table5901)
                            {
                                DataItemLink = Document No.=FIELD(No.);
                                DataItemLinkReference = "Service Header";
                                RequestFilterFields = "Requested Starting Date";
                                column(ServiceItemLine_LineNo;"Line No.")
                                {
                                }
                                column(ServiceItemLine_ServiceInvGroupNo;"Service Inv. Group No.")
                                {
                                }
                                column(ServiceItemLine_Description;Description)
                                {
                                }
                                column(ServiceItemLine_ServiceItemNo;"Service Item No.")
                                {
                                }
                                column(ServiceItem_PlannerNo;ServiceItem."Planner No")
                                {
                                }
                                column(ServiceItemLine_RequestedStartingDate;"Requested Starting Date")
                                {
                                }
                                column(InvoiceGroupDescription;InvoiceGroupDescription)
                                {
                                }
                                column(ResourceNo;ResourceNo)
                                {
                                }
                                column(ResourceName;ResourceName)
                                {
                                }
                                column(VehicleHours;VehicleHours)
                                {
                                }
                                column(AssistantHours;AssistantHours)
                                {
                                }
                                column(KMsNo;KMsNo)
                                {
                                }
                                column(ServiceHeader_AmountIncludingVAT;Amount)
                                {
                                }
                                column(ServiceHeader_AmountExcludingVAT;AmountExclVAT)
                                {
                                }
                                column(SerItemDocNo;SerItemDocNo)
                                {
                                }

                                trigger OnAfterGetRecord();
                                begin
                                    CLEAR(ServiceItem);
                                    IF ServiceItem.GET("Service Item Line"."Service Item No.") THEN;

                                    //Descripcion Grupo Facturacion
                                    CLEAR(InvoiceGroupDescription);
                                    IF ServiceItemInvoiceGroup.GET("Service Item Line"."Service Inv. Group No.") THEN
                                      InvoiceGroupDescription:=ServiceItemInvoiceGroup.Description;

                                    //Nº y Nombre de Operario
                                    CLEAR(ResourceNo);
                                    CLEAR(ResourceName);
                                    ServiceOrderAllocation.SETRANGE("Document Type",ServiceOrderAllocation."Document Type"::Order);
                                    ServiceOrderAllocation.SETRANGE("Document No.","Service Item Line"."Document No.");
                                    ServiceOrderAllocation.SETRANGE("Service Item Line No.","Service Item Line"."Line No.");
                                    ServiceOrderAllocation.SETFILTER(Status,'<>%1',ServiceOrderAllocation.Status::Canceled);
                                    ServiceOrderAllocation.SETFILTER(Responsible,'=%1',ServiceOrderAllocation.Responsible::"1");
                                    IF ServiceOrderAllocation.FINDFIRST THEN BEGIN
                                      ResourceNo:=ServiceOrderAllocation."Resource No.";
                                      ServiceOrderAllocation.CALCFIELDS("Resource Name");
                                      ResourceName:=ServiceOrderAllocation."Resource Name";
                                    END;

                                    //Nº Horas Vehiculo, Nº Horas Ayudante, Nº KMs
                                    CLEAR(VehicleHours);
                                    CLEAR(AssistantHours);
                                    CLEAR(KMsNo);
                                    CLEAR(Amount);
                                    CLEAR(SerItemDocNo);

                                    IF ServiceHeaderNo <> "Service Header"."No." THEN BEGIN
                                      SerItemDocNo:="Service Item Line"."Document No.";

                                      IF "Crane Service Quote Header"."Quote Type" = "Crane Service Quote Header"."Quote Type"::Forfait THEN BEGIN
                                        CLEAR(ServiceLine);
                                        ServiceLine.SETRANGE("Document No.","Service Item Line"."Document No.");
                                        ServiceLine.SETRANGE(Type,ServiceLine.Type::Resource);
                                    //    ServiceLine.SETRANGE("No.",CraneMgtSetup."Serv. Order Type - Crane");
                                        IF ServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            IF ServiceLine."Work Type Code" = CraneMgtSetup."Main Operator Work Type" THEN
                                              VehicleHours:=VehicleHours+ServiceLine.Quantity
                                            ELSE IF ServiceLine."Work Type Code" = CraneMgtSetup."Ass. Operator Work Type" THEN
                                              AssistantHours:=AssistantHours+ServiceLine.Quantity;
                                          UNTIL ServiceLine.NEXT = 0;
                                        END;

                                        //Calcular importes de Forfait.




                                      END ELSE BEGIN
                                        "Service Header".CALCFIELDS("Amount Including VAT",Amount);
                                        Amount:="Service Header"."Amount Including VAT";
                                        AmountExclVAT:="Service Header".Amount;

                                        CLEAR(ServiceLine);
                                        ServiceLine.SETRANGE("Document No.","Service Item Line"."Document No.");
                                        ServiceLine.SETRANGE(Type,ServiceLine.Type::Resource);
                                        ServiceLine.SETRANGE("Work Type Code",CraneMgtSetup."Main Operator Work Type");
                                        IF ServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            VehicleHours:=VehicleHours+ServiceLine.Quantity;
                                          UNTIL ServiceLine.NEXT = 0;
                                        END;

                                        //RQ19.26.919    mbedia     07/10/2020
                                        ServiceLine.SETRANGE("Work Type Code",CraneMgtSetup."Ass. Operator Work Type");
                                        //------------------------------
                                        IF ServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            AssistantHours:=AssistantHours+ServiceLine.Quantity;
                                          UNTIL ServiceLine.NEXT = 0;
                                        END;

                                        //RQ19.26.919    mbedia     07/10/2020
                                        CLEAR(ServiceLine);
                                        ServiceLine.SETRANGE("Document No.","Service Item Line"."Document No.");
                                        ServiceLine.SETRANGE(Type,ServiceLine.Type::Cost);
                                        ServiceLine.SETRANGE("No.",CraneMgtSetup."Displacement Service Cost Code");
                                        ServiceLine.SETRANGE("Unit of Measure Code",ServiceMgtSetup."Displacement Unit Of Measure");
                                        //------------------------------
                                        IF ServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            KMsNo:=KMsNo+ServiceLine.Quantity;
                                          UNTIL ServiceLine.NEXT = 0;
                                        END;

                                        //Totalizar importes
                                        TotalOperationAmount += Amount;
                                        TotalOperationAmountExclVAT += AmountExclVAT;
                                        TotalQuoteAmount += Amount;
                                        TotalQuoteAmountExclVAT += AmountExclVAT;

                                      END;
                                    END;

                                    ServiceHeaderNo := "Service Header"."No.";
                                end;
                            }

                            trigger OnPreDataItem();
                            begin
                                "Service Header".SETRANGE("Customer No.","Crane Service Quote Header"."Customer No."); // DPGARCIA - RQ19.36.557 - Filtrar por mismo cliente que en Oferta
                            end;
                        }
                        dataitem(DataItem1000000046;Table50217)
                        {
                            DataItemLink = Crane Service Quote No.=FIELD(Quote No.),
                                           Crane Serv. Quote Op. Line No=FIELD(Line No.);
                            DataItemLinkReference = "Crane Service Quote Op. Line";
                            RequestFilterFields = "No.","Order Date";
                            column(PostedServiceHeader_No;"No.")
                            {
                            }
                            column(PostedServiceHeader_OrderDate;"Order Date")
                            {
                            }
                            column(PostedServiceHeader_CraneServQuoteOpLineNo;"Crane Serv. Quote Op. Line No")
                            {
                            }
                            column(PostedServiceHeader_CraneServiceQuoteNo;"Crane Service Quote No.")
                            {
                            }
                            dataitem(DataItem1000000047;Table50218)
                            {
                                DataItemLink = No.=FIELD(No.);
                                DataItemLinkReference = "Posted Service Header";
                                RequestFilterFields = "Requested Starting Date";
                                column(PostedServiceItemLine_LineNo;"Line No.")
                                {
                                }
                                column(PostedServiceItemLine_ServiceInvGroupNo;"Service Inv. Group No.")
                                {
                                }
                                column(PostedServiceItemLine_Description;Description)
                                {
                                }
                                column(PostedServiceItemLine_ServiceItemNo;"Service Item No.")
                                {
                                }
                                column(PostedServiceItem_PlannerNo;PostedServiceItem."Planner No")
                                {
                                }
                                column(PostedServiceItemLine_RequestedStartingDate;"Requested Starting Date")
                                {
                                }
                                column(PostedInvoiceGroupDescription;PostedInvoiceGroupDescription)
                                {
                                }
                                column(PostedResourceNo;PostedResourceNo)
                                {
                                }
                                column(PostedResourceName;PostedResourceName)
                                {
                                }
                                column(PostedVehicleHours;PostedVehicleHours)
                                {
                                }
                                column(PostedAssistantHours;PostedAssistantHours)
                                {
                                }
                                column(PostedKMsNo;PostedKMsNo)
                                {
                                }
                                column(PostedServiceHeader_AmountIncludingVAT;PostedAmount)
                                {
                                }
                                column(PostedSerItemDocNo;PostedSerItemDocNo)
                                {
                                }
                                column(PostedServiceHeader_AmountExcludingVAT;PostedAmountExclVAT)
                                {
                                }

                                trigger OnAfterGetRecord();
                                begin
                                    CLEAR(PostedServiceItem);
                                    IF PostedServiceItem.GET("Posted Service Item Line"."Service Item No.") THEN;

                                    //Descripcion Grupo Facturacion
                                    CLEAR(PostedInvoiceGroupDescription);
                                    IF ServiceItemInvoiceGroup.GET("Posted Service Item Line"."Service Inv. Group No.") THEN
                                      PostedInvoiceGroupDescription:=ServiceItemInvoiceGroup.Description;

                                    //Nº y Nombre de Operario
                                    CLEAR(PostedResourceNo);
                                    CLEAR(PostedResourceName);
                                    ServiceOrderAllocation.SETRANGE("Document Type",ServiceOrderAllocation."Document Type"::Order);
                                    ServiceOrderAllocation.SETRANGE("Document No.","Posted Service Item Line"."No.");
                                    ServiceOrderAllocation.SETRANGE("Service Item Line No.","Posted Service Item Line"."Line No.");
                                    ServiceOrderAllocation.SETFILTER(Status,'<>%1',ServiceOrderAllocation.Status::Canceled);
                                    ServiceOrderAllocation.SETFILTER(Responsible,'=%1',ServiceOrderAllocation.Responsible::"1");
                                    IF ServiceOrderAllocation.FINDFIRST THEN BEGIN
                                      PostedResourceNo:=ServiceOrderAllocation."Resource No.";
                                      ServiceOrderAllocation.CALCFIELDS("Resource Name");
                                      PostedResourceName:=ServiceOrderAllocation."Resource Name";
                                    END;

                                    //Nº Horas Vehiculo, Nº Horas Ayudante, Nº KMs
                                    CLEAR(PostedVehicleHours);
                                    CLEAR(PostedAssistantHours);
                                    CLEAR(PostedKMsNo);
                                    CLEAR(PostedAmount);
                                    CLEAR(PostedSerItemDocNo);
                                    IF PostedServiceHeaderNo <> "Posted Service Header"."No." THEN BEGIN

                                      PostedSerItemDocNo:="Posted Service Item Line"."No.";

                                      IF "Crane Service Quote Header"."Quote Type" = "Crane Service Quote Header"."Quote Type"::Forfait THEN BEGIN

                                        CLEAR(PostedServiceLine);
                                        PostedServiceLine.SETRANGE("Document No.","Posted Service Item Line"."No.");
                                        PostedServiceLine.SETRANGE(Type,PostedServiceLine.Type::Resource);
                                        IF PostedServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            IF PostedServiceLine."Work Type Code" = CraneMgtSetup."Main Operator Work Type" THEN
                                              PostedVehicleHours:=PostedVehicleHours+PostedServiceLine.Quantity
                                            ELSE IF PostedServiceLine."Work Type Code" = CraneMgtSetup."Ass. Operator Work Type" THEN
                                              PostedAssistantHours:=PostedAssistantHours+PostedServiceLine.Quantity;
                                          UNTIL PostedServiceLine.NEXT = 0;
                                        END;
                                      END ELSE BEGIN

                                        "Posted Service Header".CALCFIELDS("Amount Including VAT",Amount);
                                        PostedAmount:="Posted Service Header"."Amount Including VAT";
                                        PostedAmountExclVAT:="Posted Service Header".Amount;

                                        CLEAR(PostedServiceLine);
                                        PostedServiceLine.SETRANGE("Document No.","Posted Service Item Line"."No.");
                                        PostedServiceLine.SETRANGE(Type,PostedServiceLine.Type::Resource);
                                        //PostedServiceLine.SETRANGE("No.",CraneMgtSetup."Serv. Order Type - Crane");
                                        IF PostedServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            PostedVehicleHours:=PostedVehicleHours+PostedServiceLine.Quantity;
                                          UNTIL PostedServiceLine.NEXT = 0;
                                        END;

                                        //RQ19.26.919    mbedia     07/10/2020
                                        PostedServiceLine.SETRANGE("No.",CraneMgtSetup."Ass. Operator Work Type");
                                        IF PostedServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            PostedAssistantHours:=PostedAssistantHours+PostedServiceLine.Quantity;
                                          UNTIL PostedServiceLine.NEXT = 0;
                                        END;

                                        //RQ19.26.919    mbedia     07/10/2020
                                        CLEAR(PostedServiceLine);
                                        PostedServiceLine.SETRANGE("Document No.","Posted Service Item Line"."No.");
                                        PostedServiceLine.SETRANGE(Type,PostedServiceLine.Type::Cost);
                                        PostedServiceLine.SETRANGE("No.",CraneMgtSetup."Displacement Service Cost Code");
                                        PostedServiceLine.SETRANGE("Unit of Measure Code",ServiceMgtSetup."Displacement Unit Of Measure");
                                        //-------------------------
                                        IF PostedServiceLine.FINDSET THEN BEGIN
                                          REPEAT
                                            PostedKMsNo:=PostedKMsNo+PostedServiceLine.Quantity;
                                          UNTIL PostedServiceLine.NEXT = 0;
                                        END;

                                        //Totalizar importes
                                        TotalOperationAmount += PostedAmount;
                                        TotalOperationAmountExclVAT += PostedAmountExclVAT;
                                        TotalQuoteAmount += PostedAmount;
                                        TotalQuoteAmountExclVAT += PostedAmountExclVAT;
                                      END;
                                    END;

                                    PostedServiceHeaderNo := "Posted Service Header"."No.";
                                end;
                            }

                            trigger OnPreDataItem();
                            begin
                                "Posted Service Header".SETRANGE("Customer No.","Crane Service Quote Header"."Customer No."); // DPGARCIA - RQ19.36.557 - Filtrar por mismo cliente que en Oferta
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            TotalOperationAmount := 0;
                            TotalOperationAmountExclVAT := 0;
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                      CopyText := Text003;
                      ShipmentNo := '';
                      OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                      NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                TotalQuoteAmount := 0;
                TotalQuoteAmountExclVAT := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU='Options',
                                ESP='Opciones';
                    field(NoOfCopies;NoOfCopies)
                    {
                        CaptionML = ENU='No of Copies',
                                    ESP='Nº de Copias';
                    }
                    field(bGiveTheoricalValue;bGiveTheoricalValue)
                    {
                        CaptionML = ENU='Valutate Forfait Serv. Order',
                                    ESP='Valorar Trabajo Forfait segun horas';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CraneMgtSetup.GET;
        ServiceMgtSetup.GET;
    end;

    var
        NoOfCopies : Integer;
        NoOfLoops : Integer;
        Text003 : TextConst ENU='COPY',ESP='COPIA';
        CopyText : Text[30];
        OutputNo : Integer;
        ShipmentNo : Code[20];
        ServiceInvCountPrinted : Codeunit "5902";
        CurrReport_PAGENOCaptionLbl : TextConst ENU='Page',ESP='Página';
        FechaImpresion : Date;
        CompanyLbl : Label 'GRUAS FAM, SL';
        Tittle : TextConst ENU='List of Parts by Offer',ESP='Relación de Partes por Oferta';
        CustomerLbl : TextConst ENU='CUSTOMER:',ESP='CLIENTE:';
        WorkLbl : TextConst ENU='WORK:',ESP='OBRA:';
        OfferLbl : TextConst ENU='OFFER:',ESP='OFERTA:';
        OperationLbl : TextConst ENU='OPERATION:',ESP='OPERACIÓN:';
        InvoiceGroupDescription : Text;
        ServiceItemInvoiceGroup : Record "50005";
        ResourceNo : Code[20];
        ResourceName : Text;
        ServiceOrderAllocation : Record "5950";
        VehicleHours : Decimal;
        AssistantHours : Decimal;
        KMsNo : Decimal;
        ServiceLine : Record "5902";
        CraneMgtSetup : Record "50028";
        ServiceMgtSetup : Record "5911";
        DateLbl : TextConst ENU='Date',ESP='Fecha';
        PartLbl : TextConst ENU='Part',ESP='Parte';
        InvGroupLbl : TextConst ENU='Invoice G.',ESP='G. Facturación';
        VehicleLbl : TextConst ENU='Vehicle',ESP='Vehículo';
        ResourceLbl : TextConst ENU='Resource',ESP='Operario';
        ImpVehLbl : TextConst ENU='Imp. Veh',ESP='Imp. Veh';
        HoursLbl : TextConst ENU='Hours',ESP='Horas';
        AssistantLbl : TextConst ENU='Assistants',ESP='Ayudantes';
        KmsLbl : TextConst ENU='Kms',ESP='Kms';
        ServiceHeaderNo : Code[20];
        Amount : Decimal;
        SerItemDocNo : Code[20];
        PostedServiceLine : Record "50219";
        PostedInvoiceGroupDescription : Text;
        PostedResourceNo : Code[20];
        PostedResourceName : Text;
        PostedVehicleHours : Decimal;
        PostedAssistantHours : Decimal;
        PostedKMsNo : Decimal;
        PostedAmount : Decimal;
        PostedSerItemDocNo : Code[20];
        PostedServiceHeaderNo : Code[20];
        TotalOperationLbl : TextConst ENU='Total Offer/Operation',ESP='Total Oferta/Operacion';
        TotalGeneralLbl : TextConst ENU='Total General',ESP='Total General';
        LineNoLbl : TextConst ENU='Line No.',ESP='Nº Línea';
        AmountExclVAT : Decimal;
        PostedAmountExclVAT : Decimal;
        ImpVehExclVATLbl : TextConst ENU='Imp. Veh Excl. VAT',ESP='Imp. Veh Excl. IVA';
        ServiceItem : Record "5940";
        PostedServiceItem : Record "5940";
        QuoteTypelbl : TextConst ENU='QUOTE TYPE:',ESP='TIPO OFERTA:';
        bGiveTheoricalValue : BoolEAN;
        TotalOperationAmount : Decimal;
        TotalOperationAmountExclVAT : Decimal;
        TotalQuoteAmount : Decimal;
        TotalQuoteAmountExclVAT : Decimal;
        */
}

