<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CopyofCompanies.aspx.cs" Inherits="Companies" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#cphMain_fvSelectedCompany_CompanyNotesTextBox').maxlength({

                events: [], // Array of events to be triggerd   

                maxCharacters: 500, // Characters limit  
                max: 2000,
                showFeedback: true, // True to always show user feedback, 'active' for hover/focus only


                status: true, // True to show status indicator bewlow the element   

                statusClass: "status", // The class on the status div 

                statusText: "character left", // The status text 

                notificationClass: "notification",  // Will be added when maxlength is reached 

                showAlert: false, // True to show a regular alert message   

                alertText: "You have typed too many characters.", // Text in alert message  

                slider: false // True Use counter slider

            });
            $('.maxlength-feedback').text('');



        });   //end docready            
    </script>
    <%--     original jquery I went with. --%><%--    <script type="text/javascript">
        $(document).ready(function () {
            var MaxLength = 50;

            $('#cphMain_dvSelectedCompany_tbCompanyNotes').keypress(function (e) {
                if ($(this).val().length >= MaxLength) {
                    e.preventDefault();
                }
            });
            $('#cphMain_dvSelectedCompany_tbCompanyNotes').keyup(function () {
                var total =
parseInt($(this).val().length);

                $("#cphMain_dvSelectedCompany_lblCount").html('Characters entered <b>'
+ total + '</b> out of 500.');
            });
        }); //end docready            
                    </script>
    --%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBannerWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <center>
    <br /><br />
   <asp:MultiView ID="mvCompanies" runat="server" ActiveViewIndex="0">
   

    <asp:View ID="vwGridViewCompanies" runat="server">
    

    <asp:CheckBox ID="cbShowInactiveCompanies" runat="server" AutoPostBack="True" 
        oncheckedchanged="cbShowInactiveCompanies_CheckedChanged" Font-Bold="True" 
            ForeColor="Black" Text="- Show Inactive Companies" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="btnAddNewCompany" runat="server" 
        onclick="btnAddNewCompany_Click" Font-Bold="True" ForeColor="Black" 
            onprerender="AdminControl_PreRender">Add new company</asp:LinkButton>
        <br /><br />







    <asp:GridView ID="gvCompanies" SkinID="gridview"  runat="server" DataKeyNames="CompanyID" 
        DataSourceID="dsActiveCompanies" 
        onselectedindexchanged="gvCompanies_SelectedIndexChanged" 
            ondatabound="gvCompanies_DataBound" AllowPaging="True" AllowSorting="True" 
            PageSize="5">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Select" Text="Select" onclick="LinkButton2_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyName" HeaderText="Company" 
                SortExpression="CompanyName" />
            <asp:TemplateField HeaderText="View Jobs">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" 
                        NavigateUrl='<%# Eval("CompanyID", "~/JobPostings.aspx?jpid={0}") %>' 
                        Text="View Jobs"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyCity" HeaderText="City" 
                SortExpression="CompanyCity" />
            <asp:BoundField DataField="CompanyState" HeaderText="State" 
                SortExpression="CompanyState" />
            <asp:TemplateField HeaderText="View Contacts">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("CompanyID", "~/Contacts.aspx?coid={0}") %>' 
                        Text="View Contacts"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Delete" onclientclick="return confirm('Are you sure?')" 
                        Text="Change Status"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        <asp:SqlDataSource ID="dsInactiveCompanies" runat="server" 
            ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
            DeleteCommand="Update [JFCompanies] SET [CompanyIsActive] = ~CompanyIsActive WHERE [CompanyID] = @CompanyID" 
            InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyCity], [CompanyState], [CompanyLogo]) VALUES (@CompanyName, @CompanyCity, @CompanyState, @CompanyLogo)" 
            SelectCommand="SELECT [CompanyID], [CompanyName], [CompanyCity], [CompanyState], [CompanyLogo] FROM [JFCompanies] WHERE ([CompanyIsActive] = @CompanyIsActive)" 
            UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, [CompanyLogo] = @CompanyLogo WHERE [CompanyID] = @CompanyID">
            <DeleteParameters>
                <asp:Parameter Name="CompanyID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CompanyName" Type="String" />
                <asp:Parameter Name="CompanyCity" Type="String" />
                <asp:Parameter Name="CompanyState" Type="String" />
                <asp:Parameter Name="CompanyLogo" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="false" Name="CompanyIsActive" Type="Boolean" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="CompanyName" Type="String" />
                <asp:Parameter Name="CompanyCity" Type="String" />
                <asp:Parameter Name="CompanyState" Type="String" />
                <asp:Parameter Name="CompanyLogo" Type="String" />
                <asp:Parameter Name="CompanyID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsActiveCompanies" runat="server" 
    ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
    DeleteCommand="Update [JFCompanies] SET [CompanyIsActive] = ~CompanyIsActive WHERE [CompanyID] = @CompanyID" 

    InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyCity], [CompanyState], 
    [CompanyLogo]) VALUES (@CompanyName, @CompanyCity, @CompanyState, @CompanyLogo)" 

    SelectCommand="SELECT [CompanyID], [CompanyName], [CompanyCity], [CompanyState], 
    [CompanyLogo] FROM [JFCompanies] WHERE ([CompanyIsActive] = @CompanyIsActive)" 
    
        
        UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, 
        [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, 
        [CompanyLogo] = @CompanyLogo WHERE [CompanyID] = @CompanyID">

        <DeleteParameters>
            <asp:Parameter Name="CompanyID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CompanyName" Type="String" />
            <asp:Parameter Name="CompanyCity" Type="String" />
            <asp:Parameter Name="CompanyState" Type="String" />
            <asp:Parameter Name="CompanyLogo" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="true" Name="CompanyIsActive" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CompanyName" Type="String" />
            <asp:Parameter Name="CompanyCity" Type="String" />
            <asp:Parameter Name="CompanyState" Type="String" />
            <asp:Parameter Name="CompanyLogo" Type="String" />
            <asp:Parameter Name="CompanyID" Type="Int32" />
        </UpdateParameters>
</asp:SqlDataSource>

    </asp:View><%--end vwGridViewCompanies--%>--%>
</center>
    <center>
 <asp:View ID="vwFormViewSelectedCompany" runat="server">
        
    <br />
    <br />

    <asp:FormView ID="fvSelectedCompany" runat="server" DataKeyNames="CompanyID" 
        DataSourceID="dsFVSelectedCompany" BackColor="White"  
        CellPadding="4"  
         CssClass="formview" EnableViewState="False">
<EditItemTemplate>

            CompanyLogo:
             <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server" 
                  onuploadedcomplete="AsyncFileUpload1_UploadedComplete" />
            <%--<asp:TextBox ID="CompanyLogoTextBox" runat="server" 
                Text='<%# Bind("CompanyLogo") %>' />--%>
            <br />

            CompanyIsActive:
            <asp:CheckBox ID="CompanyIsActiveCheckBox" runat="server" 
                Checked='<%# Bind("CompanyIsActive") %>' />
            <br />

            CompanyName:
            <asp:TextBox ID="CompanyNameTextBox" runat="server" 
                Text='<%# Bind("CompanyName") %>' />
            <asp:RequiredFieldValidator ID="rfvCompanyNameTB" runat="server" 
                ControlToValidate="CompanyNameTextBox" ErrorMessage="RequiredFieldValidator" 
                Font-Bold="True" Font-Italic="True" ForeColor="Black">*Company Name Required</asp:RequiredFieldValidator>
            <br />
            CompanyAddress1:
            <asp:TextBox ID="CompanyAddress1TextBox" runat="server" 
                Text='<%# Bind("CompanyAddress1") %>' />
            <br />
            CompanyAddress2:
            <asp:TextBox ID="CompanyAddress2TextBox" runat="server" 
                Text='<%# Bind("CompanyAddress2") %>' />
            <br />
            CompanyCity:
            <asp:TextBox ID="CompanyCityTextBox" runat="server" 
                Text='<%# Bind("CompanyCity") %>' />
            <br />
            CompanyState:
            <asp:TextBox ID="CompanyStateTextBox" runat="server" 
                Text='<%# Bind("CompanyState") %>' />
            <br />
            CompanyZip:
            <asp:TextBox ID="CompanyZipTextBox" runat="server" 
                Text='<%# Bind("CompanyZip") %>' />
            <br />
            CompanyPhone:
            <asp:TextBox ID="CompanyPhoneTextBox" runat="server" 
                Text='<%# Bind("CompanyPhone") %>' />
            <br />
            CompanyWebsite:
            <asp:TextBox ID="CompanyWebsiteTextBox" runat="server" 
                Text='<%# Bind("CompanyWebsite") %>' />
            <asp:TextBoxWatermarkExtender ID="CompanyWebsiteTextBox_TextBoxWatermarkExtender" 
                runat="server" TargetControlID="CompanyWebsiteTextBox" WatermarkText=" http(s)://www.web.com "
                 WatermarkCssClass="watermark">
            </asp:TextBoxWatermarkExtender>
            <br />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="CompanyWebsiteTextBox" 
                ErrorMessage="* Enter in this Format: http(s)://www.web.com" Font-Bold="True" 
                Font-Italic="True" ForeColor="Black" 
                ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
            <br />

            CompanyIndustry:
            <asp:TextBox ID="CompanyIndustryTextBox" runat="server" 
                Text='<%# Bind("CompanyIndustry") %>' />
            <br />

            CompanyNotes:
            <asp:TextBox ID="CompanyNotesTextBox" runat="server" TextMode="MultiLine" Rows="5" 
                Text='<%# Bind("CompanyNotes") %>' />

                <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
            <br />
       
          
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="btnCancel" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="Cancel" 
                onclick="UpdateCancelButton_Click" />
        </EditItemTemplate>
        <EditRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
<InsertItemTemplate>
            CompanyLogo:
             <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server" 
                  onuploadedcomplete="AsyncFileUpload1_UploadedComplete" />
             <br />
             CompanyIsActive:
            <asp:CheckBox ID="CompanyIsActiveCheckBox" runat="server" 
                Checked='<%# Bind("CompanyIsActive") %>' />
            <br />


            CompanyName:
            <asp:TextBox ID="CompanyNameTextBox" runat="server" 
                Text='<%# Bind("CompanyName") %>' />
                <asp:RequiredFieldValidator ID="rfvCompanyNameTB" runat="server" 
                ErrorMessage="RequiredFieldValidator" ControlToValidate="CompanyNameTextBox" 
                Font-Bold="True" Font-Italic="True" ForeColor="Black">*Company Name Required</asp:RequiredFieldValidator>
            <br />

            CompanyAddress1:
            <asp:TextBox ID="CompanyAddress1TextBox" runat="server" 
                Text='<%# Bind("CompanyAddress1") %>' />
            <br />

            CompanyAddress2:
            <asp:TextBox ID="CompanyAddress2TextBox" runat="server" 
                Text='<%# Bind("CompanyAddress2") %>' />
            <br />

            CompanyCity:
            <asp:TextBox ID="CompanyCityTextBox" runat="server" 
                Text='<%# Bind("CompanyCity") %>' />
            <br />

            CompanyState:
            <asp:TextBox ID="CompanyStateTextBox" runat="server" 
                Text='<%# Bind("CompanyState") %>' />
            <br />

            CompanyZip:
            <asp:TextBox ID="CompanyZipTextBox" runat="server" 
                Text='<%# Bind("CompanyZip") %>' />
            <br />

            CompanyPhone:
            <asp:TextBox ID="CompanyPhoneTextBox" runat="server" 
                Text='<%# Bind("CompanyPhone") %>' />
            <asp:TextBoxWatermarkExtender ID="CompanyPhoneTextBox_TextBoxWatermarkExtender" 
                runat="server" TargetControlID="CompanyPhoneTextBox" WatermarkCssClass="watermark"
                 WatermarkText=" (555)555-5555 ">
            </asp:TextBoxWatermarkExtender>
            <br />
            CompanyWebsite:
            <asp:TextBox ID="CompanyWebsiteTextBox" runat="server" 
                Text='<%# Bind("CompanyWebsite") %>' />
            <asp:TextBoxWatermarkExtender ID="CompanyWebsiteTextBox_TextBoxWatermarkExtender" 
                runat="server" TargetControlID="CompanyWebsiteTextBox" WatermarkText=" http(s)://www.web.com " 
                WatermarkCssClass="watermark">
            </asp:TextBoxWatermarkExtender>
            <br />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="CompanyWebsiteTextBox" 
                ErrorMessage="* Enter in this Format: http(s)://www.web.com" Font-Bold="True" 
                Font-Italic="True" ForeColor="Black" Text='<%# Eval("CompanyWebsite") %>' 
                ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
            <br />
             CompanyIndustry:
            <asp:TextBox ID="CompanyIndustryTextBox" runat="server" 
                Text='<%# Bind("CompanyIndustry") %>' />
            <br />

            CompanyNotes:
            <asp:TextBox ID="CompanyNotesTextBox" runat="server" TextMode="MultiLine" 
            Rows="5" Text='<%# Bind("CompanyNotes") %>' />
                
            
            <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
           <br />

            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="Cancel" 
                onclick="InsertCancelButton_Click" />

        </InsertItemTemplate>
 <ItemTemplate>
   <table style="width: 100%;" >
            <tr><%--Row 1--%>
              <td rowspan="5" style="width: 105px; text-align:center;">
                <asp:Image ID="Image1" runat="server" 
                  ImageUrl='<%# Bind("CompanyLogo", "~/images/{0}") %>' />
             <br />
             CompanyIsActive:
            <asp:CheckBox ID="CompanyIsActiveCheckBox" runat="server" 
                Checked='<%# Bind("CompanyIsActive") %>' Enabled="false" />
            </td>
            <td colspan="2">
            <%--CompanyName:--%>
            <%--<asp:Label ID="CompanyNameLabel" runat="server" 
                Text='<%# Bind("CompanyName") %>' />--%>
               <asp:HyperLink ID="HyperLink4" runat="server" ForeColor="#003399" Font-Size="X-Large"                
               NavigateUrl='<%# Bind("CompanyWebsite") %>' Target="_blank" 
                Text='<%# Bind("CompanyName") %>'></asp:HyperLink>
            <br />
            </td>
            </tr><%--end Row 1--%>

            <tr><%--Row 2--%>
                <td colspan="2">
    <asp:Label ID="CompanyAddress1Label" runat="server" Text='<%# Bind("CompanyAddress1") %>' />
    <br />
    <asp:Label ID="CompanyAddress2Label" runat="server" Text='<%# Bind("CompanyAddress2") %>' />
    <br />
    <asp:Label ID="CompanyCityLabel" runat="server" Text='<%# Bind("CompanyCity") %>' />
    ,
    <asp:Label ID="CompanyStateLabel" runat="server" Text='<%# Bind("CompanyState") %>' />
    <asp:Label ID="CompanyZipLabel" runat="server" Text='<%# Bind("CompanyZip") %>' />
    </td>
     </tr><%--end Row 2--%>

     <tr><%--Row 3--%>
    <td>
    <asp:Label ID="CompanyPhoneLabel" runat="server" Text='<%# Bind("CompanyPhone") %>' />
    <br />
    </td>
    <td>
    <asp:Label ID="CompanyIndustryLabel" runat="server" Text='<%# Bind("CompanyIndustry") %>' />
    <br />
   </td>
   </tr><%--End Row 3--%>
    <tr><%--Row 4--%>
    <td>
    <asp:Label ID="CompanyNotesLabel" runat="server" Text='<%# Bind("CompanyNotes") %>' />
    </td>    
    </tr><%--End Row 4--%>

    <tr><!--Row5-->
    <td colspan="2" style="text-align:right">
     &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
    CommandName="New" Text="New" Font-Bold="True" ForeColor="Black" 
            onprerender="AdminControl_PreRender" />

    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False"
    CommandName="Edit" Text="Edit" Font-Bold="True" ForeColor="Black" 
            onprerender="AdminControl_PreRender" />

    <span style="padding-left:20px;">
    </span>
    </td>
    </tr><!-- End Row5-->
    </table>
        </ItemTemplate>
        <PagerStyle BackColor="#30891B" ForeColor="#003399" HorizontalAlign="Left" CssClass="formViewBackColor"/>
        <RowStyle BackColor="#30891B" ForeColor="#003399" CssClass="formViewBackColor"/>
     </asp:FormView>












     <asp:SqlDataSource ID="dsFVSelectedCompany" runat="server" 
         ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
         
         SelectCommand="SELECT CompanyID, CompanyName, CompanyAddress1, CompanyAddress2, CompanyCity, CompanyState, CompanyZip, CompanyPhone, CompanyWebsite, CompanyNotes, CompanyIsActive, CompanyLogo, CompanyIndustry FROM JFCompanies WHERE (CompanyID = @CompanyID)" 

         oninserted="dsFVSelectedCompany_Inserted" 
         oninserting="dsFVSelectedCompany_Inserting" 
         onupdated="dsFVSelectedCompany_Updated" 
         onupdating="dsFVSelectedCompany_Updating" 
         
         UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, 
         [CompanyAddress1] = @CompanyAddress1, [CompanyAddress2] = @CompanyAddress2, 
         [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, [CompanyZip] = 
         @CompanyZip, [CompanyPhone] = @CompanyPhone, [CompanyWebsite] = @CompanyWebsite, 
         [CompanyNotes] = @CompanyNotes, [CompanyIsActive] = @CompanyIsActive, [CompanyLogo] 
         = @CompanyLogo, [CompanyIndustry] = @CompanyIndustry WHERE [CompanyID] = @CompanyID" 

          
         InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyAddress1], 
         [CompanyAddress2], [CompanyCity], [CompanyState], [CompanyZip], [CompanyPhone], 
         [CompanyWebsite], [CompanyNotes], [CompanyIsActive], [CompanyLogo], 
         [CompanyIndustry]) VALUES (@CompanyName, @CompanyAddress1, @CompanyAddress2, 
         @CompanyCity, @CompanyState, @CompanyZip, @CompanyPhone, @CompanyWebsite, 
         @CompanyNotes, @CompanyIsActive, @CompanyLogo, @CompanyIndustry)">
         
         <DeleteParameters>
             <asp:Parameter Name="CompanyID" Type="Int32" />
         </DeleteParameters>
         <InsertParameters>
             <asp:Parameter Name="CompanyName" Type="String" />
             <asp:Parameter Name="CompanyAddress1" Type="String" />
             <asp:Parameter Name="CompanyAddress2" Type="String" />
             <asp:Parameter Name="CompanyCity" Type="String" />
             <asp:Parameter Name="CompanyState" Type="String" />
             <asp:Parameter Name="CompanyZip" Type="String" />
             <asp:Parameter Name="CompanyPhone" Type="String" />
             <asp:Parameter Name="CompanyWebsite" Type="String" />
             <asp:Parameter Name="CompanyNotes" Type="String" />
             <asp:Parameter Name="CompanyIsActive" Type="Boolean" />
             <asp:Parameter Name="CompanyLogo" Type="String" />
             <asp:Parameter Name="CompanyIndustry" Type="String" />
         </InsertParameters>
         <SelectParameters>
             <asp:ControlParameter ControlID="gvCompanies" Name="CompanyID" 
                 PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
         <UpdateParameters>
             <asp:Parameter Name="CompanyName" Type="String" />
             <asp:Parameter Name="CompanyAddress1" Type="String" />
             <asp:Parameter Name="CompanyAddress2" Type="String" />
             <asp:Parameter Name="CompanyCity" Type="String" />
             <asp:Parameter Name="CompanyState" Type="String" />
             <asp:Parameter Name="CompanyZip" Type="String" />
             <asp:Parameter Name="CompanyPhone" Type="String" />
             <asp:Parameter Name="CompanyWebsite" Type="String" />
             <asp:Parameter Name="CompanyNotes" Type="String" />
             <asp:Parameter Name="CompanyIsActive" Type="Boolean" />
             <asp:Parameter Name="CompanyLogo" Type="String" />
             <asp:Parameter Name="CompanyIndustry" Type="String" />
             <asp:Parameter Name="CompanyID" Type="Int32" />
         </UpdateParameters>
     </asp:SqlDataSource>

<%--     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
         
         SelectCommand="SELECT JFCompanies.CompanyID, JFCompanies.CompanyName, JFCompanies.CompanyAddress1, JFCompanies.CompanyAddress2, JFCompanies.CompanyCity, JFCompanies.CompanyState, JFCompanies.CompanyZip, JFCompanies.CompanyPhone, JFCompanies.CompanyWebsite, JFCompanies.CompanyNotes, JFCompanies.CompanyIsActive, JFCompanies.CompanyLogo, JFCompanies.CompanyIndustry, JFCompanies_1.CompanyName AS Expr1, JFJobPostingsStatuses.JobPostingStatusName FROM JFCompanies INNER JOIN JFCompanies AS JFCompanies_1 ON JFCompanies.CompanyID = JFCompanies_1.CompanyID CROSS JOIN JFJobPostingsStatuses WHERE (JFCompanies.CompanyID = @CompanyID)" 
         oninserted="dsFVSelectedCompany_Inserted" 
         oninserting="dsFVSelectedCompany_Inserting" 
         onupdated="dsFVSelectedCompany_Updated" 
         onupdating="dsFVSelectedCompany_Updating" 

         UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = 
         @CompanyName, [CompanyAddress1] = @CompanyAddress1, [CompanyAddress2] = 
         @CompanyAddress2, [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, 
         [CompanyZip] = @CompanyZip, [CompanyPhone] = @CompanyPhone, [CompanyWebsite] = 
         @CompanyWebsite, [CompanyNotes] = @CompanyNotes, [CompanyIsActive] = 
         @CompanyIsActive, [CompanyLogo] = @CompanyLogo, [CompanyIndustry] = 
         @CompanyIndustry WHERE [CompanyID] = @CompanyID">

         <SelectParameters>
             <asp:ControlParameter ControlID="gvCompanies" Name="CompanyID" 
                 PropertyName="SelectedValue" />
         </SelectParameters>
         <UpdateParameters>
             <asp:Parameter Name="CompanyName" />
             <asp:Parameter Name="CompanyAddress1" />
             <asp:Parameter Name="CompanyAddress2" />
             <asp:Parameter Name="CompanyCity" />
             <asp:Parameter Name="CompanyState" />
             <asp:Parameter Name="CompanyZip" />
             <asp:Parameter Name="CompanyPhone" />
             <asp:Parameter Name="CompanyWebsite" />
             <asp:Parameter Name="CompanyNotes" />
             <asp:Parameter Name="CompanyIsActive" />
             <asp:Parameter Name="CompanyLogo" />
             <asp:Parameter Name="CompanyIndustry" />
             <asp:Parameter Name="CompanyID" />
         </UpdateParameters>
     </asp:SqlDataSource>
--%>



     <br />
<%--    <asp:SqlDataSource ID="dsFVSelectedCompany" runat="server" 
         ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
         DeleteCommand="DELETE FROM [JFCompanies] WHERE [CompanyID] = @CompanyID" 
         InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyAddress1], [CompanyAddress2], [CompanyCity], [CompanyState], [CompanyZip], [CompanyPhone], [CompanyWebsite], [CompanyNotes], [CompanyIsActive], [CompanyLogo], [CompanyIndustry]) VALUES (@CompanyName, @CompanyAddress1, @CompanyAddress2, @CompanyCity, @CompanyState, @CompanyZip, @CompanyPhone, @CompanyWebsite, @CompanyNotes, @CompanyIsActive, @CompanyLogo, @CompanyIndustry)" 
         oninserted="dsSelectedCompany_Inserted" 
         oninserting="dsSelectedCompany_Inserting" onupdated="dsSelectedCompany_Updated" 
         onupdating="dsSelectedCompany_Updating" 
         SelectCommand="SELECT JFCompanies.CompanyID, JFCompanies.CompanyName, JFCompanies.CompanyAddress1, JFCompanies.CompanyAddress2, JFCompanies.CompanyCity, JFCompanies.CompanyState, JFCompanies.CompanyZip, JFCompanies.CompanyPhone, JFCompanies.CompanyWebsite, JFCompanies.CompanyNotes, JFCompanies.CompanyIsActive, JFCompanies.CompanyLogo, JFCompanies.CompanyIndustry, JFCompanies_1.CompanyName AS Expr1, JFJobPostingsStatuses.JobPostingStatusName FROM JFCompanies INNER JOIN JFCompanies AS JFCompanies_1 ON JFCompanies.CompanyID = JFCompanies_1.CompanyID CROSS JOIN JFJobPostingsStatuses WHERE (JFCompanies.CompanyID = @CompanyID)" 
         UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, [CompanyAddress1] = @CompanyAddress1, [CompanyAddress2] = @CompanyAddress2, [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, [CompanyZip] = @CompanyZip, [CompanyPhone] = @CompanyPhone, [CompanyWebsite] = @CompanyWebsite, [CompanyNotes] = @CompanyNotes, [CompanyIsActive] = @CompanyIsActive, [CompanyLogo] = @CompanyLogo, [CompanyIndustry] = @CompanyIndustry WHERE [CompanyID] = @CompanyID">
         <DeleteParameters>
             <asp:Parameter Name="CompanyID" Type="Int32" />
         </DeleteParameters>
         <InsertParameters>
             <asp:Parameter Name="CompanyName" Type="String" />
             <asp:Parameter Name="CompanyAddress1" Type="String" />
             <asp:Parameter Name="CompanyAddress2" Type="String" />
             <asp:Parameter Name="CompanyCity" Type="String" />
             <asp:Parameter Name="CompanyState" Type="String" />
             <asp:Parameter Name="CompanyZip" Type="String" />
             <asp:Parameter Name="CompanyPhone" Type="String" />
             <asp:Parameter Name="CompanyWebsite" Type="String" />
             <asp:Parameter Name="CompanyNotes" Type="String" />
             <asp:Parameter Name="CompanyIsActive" Type="Boolean" />
             <asp:Parameter Name="CompanyLogo" Type="String" />
             <asp:Parameter Name="CompanyIndustry" Type="String" />
         </InsertParameters>
         <SelectParameters>
             <asp:ControlParameter ControlID="gvCompanies" Name="CompanyID" 
                 PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>
         <UpdateParameters>
             <asp:Parameter Name="CompanyName" Type="String" />
             <asp:Parameter Name="CompanyAddress1" Type="String" />
             <asp:Parameter Name="CompanyAddress2" Type="String" />
             <asp:Parameter Name="CompanyCity" Type="String" />
             <asp:Parameter Name="CompanyState" Type="String" />
             <asp:Parameter Name="CompanyZip" Type="String" />
             <asp:Parameter Name="CompanyPhone" Type="String" />
             <asp:Parameter Name="CompanyWebsite" Type="String" />
             <asp:Parameter Name="CompanyNotes" Type="String" />
             <asp:Parameter Name="CompanyIsActive" Type="Boolean" />
             <asp:Parameter Name="CompanyLogo" Type="String" />
             <asp:Parameter Name="CompanyIndustry" Type="String" />
             <asp:Parameter Name="CompanyID" Type="Int32" />
         </UpdateParameters>
     </asp:SqlDataSource>
--%>








<%--   <asp:DetailsView ID="dvSelectedCompany" SkinID="detailsview" runat="server" 
        DataKeyNames="CompanyID" DataSourceID="dsSelectedCompany" 
        EnableViewState="False" ondatabound="dvSelectedCompany_DataBound">
        <Fields>
            <asp:TemplateField HeaderText="IsActive" SortExpression="CompanyIsActive">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("CompanyIsActive") %>' />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("CompanyIsActive") %>' />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("CompanyIsActive") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Logo" SortExpression="CompanyLogo">
                <EditItemTemplate>
                    &nbsp;<asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server" 
                        onuploadedcomplete="AsyncFileUpload1_UploadedComplete" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server" 
                        onuploadedcomplete="AsyncFileUpload1_UploadedComplete" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" 
                        ImageUrl='<%# Bind("CompanyLogo", "~/images/{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="* Company" SortExpression="CompanyName">
                <EditItemTemplate>
                    &nbsp;<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox3" ErrorMessage="* Required Field"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <HeaderTemplate>
                    Company
                </HeaderTemplate>
                <InsertItemTemplate>
                    &nbsp;<asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox4" ErrorMessage="* Required Field"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyAddress1" HeaderText="Address1" 
                SortExpression="CompanyAddress1" />
            <asp:BoundField DataField="CompanyAddress2" HeaderText="Address2" 
                SortExpression="CompanyAddress2" />
            <asp:BoundField DataField="CompanyCity" HeaderText="City" 
                SortExpression="CompanyCity" />
            <asp:BoundField DataField="CompanyState" HeaderText="State" 
                SortExpression="CompanyState" />
            <asp:BoundField DataField="CompanyZip" HeaderText="Zip" 
                SortExpression="CompanyZip" />
            <asp:TemplateField HeaderText="Phone" SortExpression="CompanyPhone">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("CompanyPhone") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CompanyPhone") %>'></asp:TextBox>
                    <asp:TextBoxWatermarkExtender ID="TextBox1_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="TextBox1" WatermarkText=" (555)555-5555 " 
                        WatermarkCssClass="watermark">
                    </asp:TextBoxWatermarkExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CompanyPhone") %>'></asp:TextBox>
                    <asp:TextBoxWatermarkExtender ID="TextBox1_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="TextBox1" WatermarkText=" (555)555-5555 " 
                        WatermarkCssClass="watermark">
                    </asp:TextBoxWatermarkExtender>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Website" SortExpression="CompanyWebsite">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CompanyWebsite") %>'></asp:TextBox>
                    <asp:TextBoxWatermarkExtender ID="TextBox2_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="TextBox2" WatermarkCssClass="watermark" 
                        WatermarkText="http://www.website.com">
                    </asp:TextBoxWatermarkExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CompanyWebsite") %>'></asp:TextBox>
                    <asp:TextBoxWatermarkExtender ID="TextBox2_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="TextBox2" WatermarkCssClass="watermark" 
                        WatermarkText="http://www.website.com">
                    </asp:TextBoxWatermarkExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Bind("CompanyWebsite") %>' Target="_blank" 
                        Text='<%# Bind("CompanyWebsite") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyIndustry" HeaderText="Industry" 
                SortExpression="CompanyIndustry" />
            <asp:TemplateField HeaderText="Notes" SortExpression="CompanyNotes">
                <EditItemTemplate>
                    <asp:TextBox ID="tbCompanyNotes" runat="server" Rows="5" 
                        Text='<%# Bind("CompanyNotes") %>' TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbCompanyNotes" runat="server" Rows="5" 
                        Text='<%# Bind("CompanyNotes") %>' TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CompanyNotes") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <table align="center" class="style1">
                        <tr>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                    CommandName="Edit" Text="Edit"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="New" Text="New"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    &nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;<table align="center" class="style1">
                        <tr>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                    CommandName="Update" Text="Update"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" onclick="LinkButton2_Click" Text="Cancel"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <InsertItemTemplate>
                    &nbsp;<table align="center" class="style1">
                        <tr>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                    CommandName="Insert" Text="Insert"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" onclick="LinkButton2_Click" Text="Cancel"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
--%>    <%--<asp:SqlDataSource ID="dsSelectedCompany" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFCompanies] WHERE [CompanyID] = @CompanyID" 
        InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyAddress1], [CompanyAddress2], [CompanyCity], [CompanyState], [CompanyZip], [CompanyPhone], [CompanyWebsite], [CompanyNotes], [CompanyIsActive], [CompanyLogo], [CompanyIndustry]) VALUES (@CompanyName, @CompanyAddress1, @CompanyAddress2, @CompanyCity, @CompanyState, @CompanyZip, @CompanyPhone, @CompanyWebsite, @CompanyNotes, @CompanyIsActive, @CompanyLogo, @CompanyIndustry)" 
        SelectCommand="SELECT JFCompanies.CompanyID, JFCompanies.CompanyName, JFCompanies.CompanyAddress1, JFCompanies.CompanyAddress2, JFCompanies.CompanyCity, JFCompanies.CompanyState, JFCompanies.CompanyZip, JFCompanies.CompanyPhone, JFCompanies.CompanyWebsite, JFCompanies.CompanyNotes, JFCompanies.CompanyIsActive, JFCompanies.CompanyLogo, JFCompanies.CompanyIndustry, JFCompanies_1.CompanyName AS Expr1, JFJobPostingsStatuses.JobPostingStatusName FROM JFCompanies INNER JOIN JFCompanies AS JFCompanies_1 ON JFCompanies.CompanyID = JFCompanies_1.CompanyID CROSS JOIN JFJobPostingsStatuses WHERE (JFCompanies.CompanyID = @CompanyID)" 
        
                UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, [CompanyAddress1] = @CompanyAddress1, [CompanyAddress2] = @CompanyAddress2, [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, [CompanyZip] = @CompanyZip, [CompanyPhone] = @CompanyPhone, [CompanyWebsite] = @CompanyWebsite, [CompanyNotes] = @CompanyNotes, [CompanyIsActive] = @CompanyIsActive, [CompanyLogo] = @CompanyLogo, [CompanyIndustry] = @CompanyIndustry WHERE [CompanyID] = @CompanyID" 
                oninserted="dsSelectedCompany_Inserted" 
                oninserting="dsSelectedCompany_Inserting" onupdated="dsSelectedCompany_Updated" 
                onupdating="dsSelectedCompany_Updating">
        <DeleteParameters>
            <asp:Parameter Name="CompanyID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CompanyName" Type="String" />
            <asp:Parameter Name="CompanyAddress1" Type="String" />
            <asp:Parameter Name="CompanyAddress2" Type="String" />
            <asp:Parameter Name="CompanyCity" Type="String" />
            <asp:Parameter Name="CompanyState" Type="String" />
            <asp:Parameter Name="CompanyZip" Type="String" />
            <asp:Parameter Name="CompanyPhone" Type="String" />
            <asp:Parameter Name="CompanyWebsite" Type="String" />
            <asp:Parameter Name="CompanyNotes" Type="String" />
            <asp:Parameter Name="CompanyIsActive" Type="Boolean" />
            <asp:Parameter Name="CompanyLogo" Type="String" />
            <asp:Parameter Name="CompanyIndustry" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCompanies" Name="CompanyID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CompanyName" Type="String" />
            <asp:Parameter Name="CompanyAddress1" Type="String" />
            <asp:Parameter Name="CompanyAddress2" Type="String" />
            <asp:Parameter Name="CompanyCity" Type="String" />
            <asp:Parameter Name="CompanyState" Type="String" />
            <asp:Parameter Name="CompanyZip" Type="String" />
            <asp:Parameter Name="CompanyPhone" Type="String" />
            <asp:Parameter Name="CompanyWebsite" Type="String" />
            <asp:Parameter Name="CompanyNotes" Type="String" />
            <asp:Parameter Name="CompanyIsActive" Type="Boolean" />
            <asp:Parameter Name="CompanyLogo" Type="String" />
            <asp:Parameter Name="CompanyIndustry" Type="String" />
            <asp:Parameter Name="CompanyID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>--%>
   <asp:LinkButton ID="btnBackToCompanies" runat="server" 
        onclick="btnBackToCompanies_Click" CausesValidation="False" Font-Bold="True" 
                ForeColor="Black">Back to companies</asp:LinkButton>

</asp:View><%--end vwDetailsViewSelectedCompany--%>
        </asp:MultiView>
</center>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphSideLeft" runat="Server">
</asp:Content>
