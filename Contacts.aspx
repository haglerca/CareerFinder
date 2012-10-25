<%@ Page Title="Contacts" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contacts.aspx.cs" Inherits="Contacts" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {
            $('#cphMain_dvSelectedContact_tbContactNotes').maxlength({

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




<%--<script type="text/javascript">
    $(document).ready(function () {
        var MaxLength = 50;

        $('#cphMain_dvSelectedContact_tbContactNotes').keypress(function (e) {
            if ($(this).val().length >= MaxLength) {
                e.preventDefault();
            }
        });
        $('#cphMain_dvSelectedContact_tbContactNotes').keyup(function () {
            var total =
parseInt($(this).val().length);

            $("#cphMain_dvSelectedContact_lblCount").html('Characters entered <b>'
+ total + '</b> out of 500.');
        });
    }); //end docready            
                    </script>
--%>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMenu" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphBannerWrapper" Runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <center>
    <asp:MultiView ID="mvContacts" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwGridViewContacts" runat="server">
        
        <br />


            <br />
            <br />


    <asp:CheckBox ID="cbShowInactiveContacts" runat="server" AutoPostBack="True" 
        Font-Bold="True" ForeColor="Black" Text="- Show Inactive Contacts" 
        oncheckedchanged="cbShowInactiveContacts_CheckedChanged" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;
            <asp:LinkButton ID="btnAddNewContact" runat="server" 
                onclick="btnAddNewContact_Click" Font-Bold="True" ForeColor="Black" 
                onprerender="AdminControl_PreRender">Add New Contact</asp:LinkButton>
<br /><br />
    <asp:GridView ID="gvContacts" skinId="gridview" runat="server" AllowPaging="True" 
    onselectedindexchanged="gvContacts_SelectedIndexChanged" 
        DataKeyNames="ContactID" DataSourceID="dsActiveConacts"  
                ondatabound="gvContacts_DataBound" AllowSorting="True" PageSize="5">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Select" Text="Select"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ContactName" HeaderText="Contact" 
                SortExpression="ContactName" />
            <asp:TemplateField HeaderText="View Communication">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("ContactID", "~/communications.aspx?contid={0}") %>'>View Communication</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyName" HeaderText="Company" 
                SortExpression="CompanyName" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Delete" 
                        Text="Change Status" onclientclick="return confirm('Are you sure?')"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dsActiveConacts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="UPDATE JFContacts SET ContactIsActive = ~ ContactIsActive WHERE (ContactID = @ContactID)" 
        InsertCommand="INSERT INTO [JFContacts] ([ContactName], [ContactCompanyID], [ContactIsActive]) VALUES (@ContactName, @ContactCompanyID, @ContactIsActive)" 
        SelectCommand="SELECT JFContacts.ContactID, JFContacts.ContactName, JFContacts.ContactCompanyID, JFContacts.ContactIsActive, JFCompanies.CompanyName FROM JFContacts INNER JOIN JFCompanies ON JFContacts.ContactCompanyID = JFCompanies.CompanyID WHERE (JFContacts.ContactIsActive = @ContactIsActive)" 
        
                
                UpdateCommand="UPDATE [JFContacts] SET [ContactName] = @ContactName, [ContactCompanyID] = @ContactCompanyID, [ContactIsActive] = @ContactIsActive WHERE [ContactID] = @ContactID">
        <DeleteParameters>
            <asp:Parameter Name="ContactID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactCompanyID" Type="Int32" />
            <asp:Parameter Name="ContactIsActive" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="true" Name="ContactIsActive" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactCompanyID" Type="Int32" />
            <asp:Parameter Name="ContactIsActive" Type="Boolean" />
            <asp:Parameter Name="ContactID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
            <asp:LinkButton ID="btnBackToCompanies" runat="server" Font-Bold="True" 
                ForeColor="Black" onclick="btnBackToCompanies_Click" Visible="False">Back To Companies</asp:LinkButton>
    <asp:SqlDataSource ID="dsInactiveConacts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="Update [JFContacts] SET [ContactIsActive] = ~ContactIsActive WHERE [ContactID] = @ContactID" 

        InsertCommand="INSERT INTO [JFContacts] ([ContactName], [ContactCompanyID], 
        [ContactIsActive]) VALUES (@ContactName, @ContactCompanyID, @ContactIsActive)" 

        SelectCommand="SELECT JFContacts.ContactID, JFContacts.ContactName, JFContacts.ContactCompanyID, 
        JFContacts.ContactIsActive, JFCompanies.CompanyName FROM JFContacts 
        INNER JOIN JFCompanies ON JFContacts.ContactCompanyID = JFCompanies.CompanyID 
        WHERE (JFContacts.ContactIsActive = @ContactIsActive)" 

        UpdateCommand="UPDATE [JFContacts] SET [ContactName] = @ContactName, [ContactCompanyID] = @ContactCompanyID, 
        [ContactIsActive] = @ContactIsActive WHERE [ContactID] = @ContactID">

        <DeleteParameters>
            <asp:Parameter Name="ContactID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactCompanyID" Type="Int32" />
            <asp:Parameter Name="ContactIsActive" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="false" Name="ContactIsActive" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactCompanyID" Type="Int32" />
            <asp:Parameter Name="ContactIsActive" Type="Boolean" />
            <asp:Parameter Name="ContactID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

            <br />
            <asp:SqlDataSource ID="dsActiveContactsByQS" runat="server" 
                ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                DeleteCommand="DELETE FROM [JFContacts] WHERE [ContactID] = @ContactID" 
                InsertCommand="INSERT INTO [JFContacts] ([ContactName], [ContactOfficePhone], [ContactMobilePhone], [ContactEmail], [ContactCompanyID], [ContactNotes], [ContactIsActive]) VALUES (@ContactName, @ContactOfficePhone, @ContactMobilePhone, @ContactEmail, @ContactCompanyID, @ContactNotes, @ContactIsActive)" 
                SelectCommand="SELECT JFContacts.ContactID, JFContacts.ContactName, JFContacts.ContactOfficePhone, JFContacts.ContactMobilePhone, JFContacts.ContactEmail, JFContacts.ContactCompanyID, JFContacts.ContactNotes, JFContacts.ContactIsActive, JFCompanies.CompanyName FROM JFContacts INNER JOIN JFCompanies ON JFContacts.ContactCompanyID = JFCompanies.CompanyID WHERE (JFContacts.ContactIsActive = @ContactIsActive) AND (JFContacts.ContactCompanyID = @ContactCompanyID)" 
                UpdateCommand="UPDATE [JFContacts] SET [ContactName] = @ContactName, [ContactOfficePhone] = @ContactOfficePhone, [ContactMobilePhone] = @ContactMobilePhone, [ContactEmail] = @ContactEmail, [ContactCompanyID] = @ContactCompanyID, [ContactNotes] = @ContactNotes, [ContactIsActive] = @ContactIsActive WHERE [ContactID] = @ContactID">
                <DeleteParameters>
                    <asp:Parameter Name="ContactID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="ContactOfficePhone" Type="String" />
                    <asp:Parameter Name="ContactMobilePhone" Type="String" />
                    <asp:Parameter Name="ContactEmail" Type="String" />
                    <asp:Parameter Name="ContactCompanyID" Type="Int32" />
                    <asp:Parameter Name="ContactNotes" Type="String" />
                    <asp:Parameter Name="ContactIsActive" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="ContactIsActive" Type="Boolean" />
                    <asp:QueryStringParameter Name="ContactCompanyID" QueryStringField="coid" 
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="ContactOfficePhone" Type="String" />
                    <asp:Parameter Name="ContactMobilePhone" Type="String" />
                    <asp:Parameter Name="ContactEmail" Type="String" />
                    <asp:Parameter Name="ContactCompanyID" Type="Int32" />
                    <asp:Parameter Name="ContactNotes" Type="String" />
                    <asp:Parameter Name="ContactIsActive" Type="Boolean" />
                    <asp:Parameter Name="ContactID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

<br /><br />

</asp:View><%--end vwGridViewContacts--%>
</center>

<center>
        <asp:View ID="vwDetailsViewSelectedContact" runat="server">
        

    <asp:DetailsView ID="dvSelectedContact" SkinID="detailsview" runat="server"
        DataSourceID="dsSelectedContact" DataKeyNames="ContactID" EnableViewState="False" 
                ondatabound="dvSelectedContact_DataBound">
        <Fields>
            <asp:TemplateField HeaderText="Name" 
                SortExpression="ContactName">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("ContactName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ContactName") %>'></asp:TextBox>
                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox4" ErrorMessage="* Required field" Font-Bold="True" 
                        Font-Italic="True" ForeColor="Black"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ContactName") %>'></asp:TextBox>
                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox4" ErrorMessage="* Required Field" Font-Bold="True" 
                        Font-Italic="True" ForeColor="Black"></asp:RequiredFieldValidator>
                    &nbsp;
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Contact Is Active" 
                SortExpression="ContactIsActive">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("ContactIsActive") %>' />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("ContactIsActive") %>' />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("ContactIsActive") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Company" 
                SortExpression="CompanyName">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="CompanyName" 
                        DataValueField="CompanyID" SelectedValue='<%# Bind("ContactCompanyID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Company-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="rfvCompanyDDL" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="* Choose a Company" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1"></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [CompanyName], [CompanyID] FROM [JFCompanies]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="CompanyName" 
                        DataValueField="CompanyID" SelectedValue='<%# Bind("ContactCompanyID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Company-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="rfvCompanyDDL" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="* Choose a Company" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1"></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [CompanyName], [CompanyID] FROM [JFCompanies]">
                    </asp:SqlDataSource>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Office Phone" 
                SortExpression="ContactOfficePhone">
                <EditItemTemplate>
                    <asp:TextBox ID="tbOfficePhone" runat="server" 
                        Text='<%# Bind("ContactOfficePhone") %>'></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="rfvOfficePhoneTB" ForeColor="Black" Font-Italic="True"
                    Font-Bold="true" runat="server" 
                        ControlToValidate="tbOfficePhone" 
                        ErrorMessage="Please enter # in correct format (555)555-5555" 
                        Text='<%# Eval("ContactOfficePhone") %>' 
                        ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}" ></asp:RegularExpressionValidator>
                    <asp:TextBoxWatermarkExtender ID="tbOfficePhone_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="tbOfficePhone" WatermarkText=" (555)555-5555 " 
                        WatermarkCssClass="watermark">
                    </asp:TextBoxWatermarkExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbOfficePhone" runat="server" 
                        Text='<%# Bind("ContactOfficePhone") %>'></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="rfvOfficePhoneTB" ForeColor="Black" Font-Italic="True"
                    Font-Bold="true" runat="server" 
                        ControlToValidate="tbOfficePhone" 
                        ErrorMessage="Please enter # in correct format (555)555-5555" 
                        Text='<%# Eval("ContactOfficePhone") %>' 
                        ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
                    <asp:TextBoxWatermarkExtender ID="tbOfficePhone_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="tbOfficePhone" WatermarkCssClass="watermark" 
                        WatermarkText=" (555)555-5555 ">
                    </asp:TextBoxWatermarkExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("ContactOfficePhone") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Mobile Phone" 
                SortExpression="ContactMobilePhone">
                <EditItemTemplate>
                    <asp:TextBox ID="tbMobilePhone" runat="server" 
                        Text='<%# Bind("ContactMobilePhone") %>'></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="rfvMobilePhoneTB" runat="server" 
                        ControlToValidate="tbMobilePhone" Font-Bold="True" 
                        Font-Italic="True" ForeColor="Black"
                        ErrorMessage="Please enter # in correct format (555)555-5555" 
                        Text='<%# Eval("ContactOfficePhone") %>' 
                        ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
                    <asp:TextBoxWatermarkExtender ID="tbMobilePhone_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="tbMobilePhone" WatermarkCssClass="watermark" 
                        WatermarkText="(555)555-5555" >
                    </asp:TextBoxWatermarkExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbMobilePhone" runat="server" 
                        Text='<%# Bind("ContactMobilePhone") %>'></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="rfvMobilePhoneTB" runat="server" 
                        ControlToValidate="tbMobilePhone" Font-Bold="True" 
                        Font-Italic="True" ForeColor="Black"
                        ErrorMessage="Please enter # in correct format (555)555-5555" 
                        Text='<%# Eval("ContactOfficePhone") %>' 
                        ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
                    <asp:TextBoxWatermarkExtender ID="tbMobilePhone_TextBoxWatermarkExtender" WatermarkCssClass="watermark" 
                    WatermarkText="(555)555-5555"
                        runat="server" TargetControlID="tbMobilePhone">
                    </asp:TextBoxWatermarkExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("ContactMobilePhone") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email" SortExpression="ContactEmail">
                <EditItemTemplate>
                    <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("ContactEmail") %>'></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="tbEmail" ErrorMessage="Enter valid email abc@gmail.com" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <asp:TextBoxWatermarkExtender ID="tbEmail_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="tbEmail" WatermarkCssClass="watermark"
                        WatermarkText="email@gmail.com">
                    </asp:TextBoxWatermarkExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("ContactEmail") %>'></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="tbEmail" ErrorMessage="Enter valid email abc@gmail.com" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <asp:TextBoxWatermarkExtender ID="tbEmail_TextBoxWatermarkExtender" 
                        runat="server" TargetControlID="tbEmail" WatermarkCssClass="watermark"
                        WatermarkText="email@gmail.com" >
                    </asp:TextBoxWatermarkExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ContactEmail") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Notes" SortExpression="ContactNotes">
                <EditItemTemplate>
                    <asp:TextBox ID="tbContactNotes" runat="server" Text='<%# Bind("ContactNotes") %>' 
                        Rows="5" TextMode="MultiLine"></asp:TextBox>
                
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbContactNotes" runat="server" Text='<%# Bind("ContactNotes") %>' 
                        Rows="5" TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ContactNotes") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" onclick="LinkButton2_Click1" Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="Insert" onclick="LinkButton1_Click"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" onclick="LinkButton2_Click" Text="Cancel"></asp:LinkButton>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Edit">Edit</asp:LinkButton>
                    &nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton4" runat="server" CommandName="New">New</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="dsSelectedContact" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFContacts] WHERE [ContactID] = @ContactID" 
        InsertCommand="INSERT INTO [JFContacts] ([ContactName], [ContactOfficePhone], [ContactMobilePhone], [ContactEmail], [ContactCompanyID], [ContactNotes], [ContactIsActive]) VALUES (@ContactName, @ContactOfficePhone, @ContactMobilePhone, @ContactEmail, @ContactCompanyID, @ContactNotes, @ContactIsActive)" 

        SelectCommand="SELECT JFContacts.ContactID, JFContacts.ContactName, JFContacts.ContactOfficePhone, JFContacts.ContactMobilePhone, JFContacts.ContactEmail, JFContacts.ContactCompanyID, JFContacts.ContactNotes, JFContacts.ContactIsActive, JFCompanies.CompanyName FROM JFContacts INNER JOIN JFCompanies ON JFContacts.ContactCompanyID = JFCompanies.CompanyID WHERE (JFContacts.ContactID = @ContactID)" 

        
                
                UpdateCommand="UPDATE [JFContacts] SET [ContactName] = @ContactName, 
                [ContactOfficePhone] = @ContactOfficePhone, [ContactMobilePhone] 
                = @ContactMobilePhone, [ContactEmail] = @ContactEmail, [ContactCompanyID] 
                = @ContactCompanyID, [ContactNotes] = @ContactNotes, [ContactIsActive] = 
                @ContactIsActive WHERE [ContactID] = @ContactID" 
                oninserted="dsSelectedContact_Inserted" onupdated="dsSelectedContact_Updated">

        <DeleteParameters>
            <asp:Parameter Name="ContactID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactOfficePhone" Type="String" />
            <asp:Parameter Name="ContactMobilePhone" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="ContactCompanyID" Type="Int32" />
            <asp:Parameter Name="ContactNotes" Type="String" />
            <asp:Parameter Name="ContactIsActive" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvContacts" Name="ContactID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactOfficePhone" Type="String" />
            <asp:Parameter Name="ContactMobilePhone" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="ContactCompanyID" Type="Int32" />
            <asp:Parameter Name="ContactNotes" Type="String" />
            <asp:Parameter Name="ContactIsActive" Type="Boolean" />
            <asp:Parameter Name="ContactID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

  





            <br />
            <asp:LinkButton ID="btnBackToContacts" runat="server" Font-Bold="True" 
                ForeColor="Black" onclick="btnBackToContacts_Click">Back To Contacts</asp:LinkButton>

  





</asp:View><%--end vwDetailsViewSelectedContact--%>
        </asp:MultiView>
</center>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="cphSideLeft" Runat="Server">
</asp:Content>

