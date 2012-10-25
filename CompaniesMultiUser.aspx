<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CompaniesMultiUser.aspx.cs" Inherits="Companies" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMenu" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphBannerWrapper" Runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" Runat="Server">
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
        onclick="btnAddNewCompany_Click" Font-Bold="True" ForeColor="Black">Add new company</asp:LinkButton>
        <br /><br />
    <asp:GridView ID="gvCompanies" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CompanyID" 
        DataSourceID="dsActiveCompanies" 
        onselectedindexchanged="gvCompanies_SelectedIndexChanged" BackColor="White" 
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            Width="614px">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Select" Text="Select" onclick="LinkButton2_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyName" HeaderText="Company Name" 
                SortExpression="CompanyName" />
            <asp:BoundField DataField="CompanyCity" HeaderText="City" 
                SortExpression="CompanyCity" />
            <asp:BoundField DataField="CompanyState" HeaderText="State" 
                SortExpression="CompanyState" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Delete" onclientclick="return confirm('Are you sure?')" 
                        Text="Change Status"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
        <RowStyle BackColor="White" ForeColor="#003399" />
        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        <SortedAscendingCellStyle BackColor="#EDF6F6" />
        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
        <SortedDescendingCellStyle BackColor="#D6DFDF" />
        <SortedDescendingHeaderStyle BackColor="#002876" />
    </asp:GridView>
    <asp:SqlDataSource ID="dsActiveCompanies" runat="server" 
    ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
    DeleteCommand="Update [JFCompanies] SET [CompanyIsActive] = ~CompanyIsActive WHERE [CompanyID] = @CompanyID" 
    InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyCity], [CompanyState], 
    [CompanyLogo]) VALUES (@CompanyName, @CompanyCity, @CompanyState, @CompanyLogo)" 
    SelectCommand="SELECT [CompanyID], [CompanyName], [CompanyCity], [CompanyState], 
    [CompanyLogo] FROM [JFCompanies] WHERE ([CompanyIsActive] = @CompanyIsActive) AND Username = @Username" 
    
        
        UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, 
        [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, 
        [CompanyLogo] = @CompanyLogo WHERE [CompanyID] = @CompanyID" 
            onselecting="dsActiveCompanies_Selecting">
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
            <asp:Parameter DefaultValue="" Name="Username" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CompanyName" Type="String" />
            <asp:Parameter Name="CompanyCity" Type="String" />
            <asp:Parameter Name="CompanyState" Type="String" />
            <asp:Parameter Name="CompanyLogo" Type="String" />
            <asp:Parameter Name="CompanyID" Type="Int32" />
        </UpdateParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="dsInactiveCompanies" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="Update [JFCompanies] SET [CompanyIsActive] = ~CompanyIsActive WHERE [CompanyID] = @CompanyID" 
        InsertCommand="INSERT INTO [JFCompanies] ([CompanyName], [CompanyCity], [CompanyState], [CompanyLogo]) VALUES (@CompanyName, @CompanyCity, @CompanyState, @CompanyLogo)" 
        SelectCommand="SELECT [CompanyID], [CompanyName], [CompanyCity], [CompanyState], [CompanyLogo] FROM [JFCompanies] WHERE ([CompanyIsActive] = @CompanyIsActive) AND Username = @Username" 
        
            UpdateCommand="UPDATE [JFCompanies] SET [CompanyName] = @CompanyName, [CompanyCity] = @CompanyCity, [CompanyState] = @CompanyState, [CompanyLogo] = @CompanyLogo WHERE [CompanyID] = @CompanyID" 
            onselecting="dsInactiveCompanies_Selecting">
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
            <asp:Parameter Name="Username" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CompanyName" Type="String" />
            <asp:Parameter Name="CompanyCity" Type="String" />
            <asp:Parameter Name="CompanyState" Type="String" />
            <asp:Parameter Name="CompanyLogo" Type="String" />
            <asp:Parameter Name="CompanyID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    </asp:View><%--end vwGridViewCompanies--%>
</center>

<center>
        <asp:View ID="vwDetailsViewSelectedCompany" runat="server">
        
    <br />
    <br />


    <asp:DetailsView ID="dvSelectedCompany" runat="server" Height="50px" 
        Width="554px" AutoGenerateRows="False" DataKeyNames="CompanyID" 
        DataSourceID="dsSelectedCompany" EnableViewState="False" BackColor="White" 
                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
        <EditRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        <Fields>
            <asp:BoundField DataField="CompanyID" HeaderText="ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="CompanyID" />
            <asp:TemplateField HeaderText="* Company" SortExpression="CompanyName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                    &nbsp;
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="* Required Field " Font-Bold="True" 
                        Font-Italic="True" Font-Size="Medium"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                    &nbsp;<asp:RequiredFieldValidator ID="rfvName" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="*Required Field" Font-Bold="True" 
                        Font-Italic="True" Font-Size="Medium"></asp:RequiredFieldValidator>
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
            <asp:BoundField DataField="CompanyPhone" HeaderText="Phone" 
                SortExpression="CompanyPhone" />
            <asp:TemplateField HeaderText="Website" SortExpression="CompanyWebsite">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CompanyWebsite") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CompanyWebsite") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Bind("CompanyWebsite") %>' Target="_blank" 
                        Text='<%# Bind("CompanyWebsite") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CompanyNotes" HeaderText="Notes" 
                SortExpression="CompanyNotes" />
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
            <asp:BoundField DataField="CompanyIndustry" HeaderText="Industry" 
                SortExpression="CompanyIndustry" />
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    &nbsp;<table align="center" class="style1">
                        <tr>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                    CommandName="Update" Text="Update"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="Cancel"></asp:LinkButton>
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
                                    CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
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
            </asp:TemplateField>
        </Fields>
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="dsSelectedCompany" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFCompanies] WHERE [CompanyID] = @CompanyID" 
        InsertCommand="INSERT INTO JFCompanies(CompanyName, CompanyAddress1, CompanyAddress2, CompanyCity, CompanyState, CompanyZip, CompanyPhone, CompanyWebsite, CompanyNotes, CompanyIsActive, CompanyLogo, CompanyIndustry, Username) VALUES (@CompanyName, @CompanyAddress1, @CompanyAddress2, @CompanyCity, @CompanyState, @CompanyZip, @CompanyPhone, @CompanyWebsite, @CompanyNotes, @CompanyIsActive, @CompanyLogo, @CompanyIndustry, @Username)" 
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
            <asp:Parameter Name="Username" />
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
    <asp:LinkButton ID="btnBackToCompanies" runat="server" 
        onclick="btnBackToCompanies_Click" CausesValidation="False" Font-Bold="True" 
                ForeColor="Black">Back to companies</asp:LinkButton>

</asp:View><%--end vwDetailsViewSelectedCompany--%>
    </asp:MultiView>
</center>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="cphSideLeft" Runat="Server">
</asp:Content>

