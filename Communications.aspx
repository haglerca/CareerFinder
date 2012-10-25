<%@ Page Title="Communications" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Communications.aspx.cs" Inherits="Communications" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#cphMain_dvSelectedCommunication_tbCommunicationNotes').maxlength({

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

            //// original jquery I went with. 
            //            var MaxLength = 500;

            //            $('#cphMain_dvSelectedCommunication_tbCommunicationNotes').keypress(function (e) {
            //                if ($(this).val().length >= MaxLength) {
            //                    e.preventDefault();
            //                }
            //            });
            //            $('#cphMain_dvSelectedCommunication_tbCommunicationNotes').keyup(function () {
            //                var total =
            //parseInt($(this).val().length);

            //                $("#cphMain_dvSelectedCommunication_lblCount").html('Characters entered <b>'
            //+ total + '</b> out of 500.');
            //            });
        });   //end docready            
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMenu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBannerWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <center>
<asp:MultiView ID="mvCommunications" runat="server" ActiveViewIndex="0">
<asp:View ID="vwGridViewCommunications" runat="server">

    <asp:LinkButton ID="btnBackToJobPostings" runat="server" Font-Bold="True" 
        ForeColor="Black" onclick="btnBackToJobPostings_Click" Visible="False">Back To Job Postings</asp:LinkButton>

    <br />
    <br />
    <asp:LinkButton ID="btnBackToContacts" runat="server" Font-Bold="True" 
        ForeColor="Black" onclick="LinkButton3_Click" Visible="False">Back To Contacts</asp:LinkButton>

<br /><br />

    <asp:LinkButton ID="btnAddNewCommunication" runat="server" Font-Bold="True" 
        ForeColor="Black" onclick="btnAddNewCommunication_Click" 
        onprerender="AdminControl_PreRender">Add New Communication</asp:LinkButton>
        <br />
        <asp:DropDownList ID="ddlJobPostings" runat="server" AutoPostBack="True" 
        DataSourceID="dsJobPostings" DataTextField="ddlText" 
        DataValueField="JobPostingID" 
        onselectedindexchanged="ddlJobPostings_SelectedIndexChanged" 
        AppendDataBoundItems="True">
            <asp:ListItem Value="-1">[-Select A Job Posting-]</asp:ListItem>
    </asp:DropDownList>
        <asp:SqlDataSource ID="dsJobPostings" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        
        SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, JFJobPostings.JobPostingCompanyID, JFCompanies.CompanyName, JFJobPostings.JobPostingJobTitle + ' - ' + JFCompanies.CompanyName AS ddlText FROM JFJobPostings INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID"></asp:SqlDataSource>
        &nbsp;<br /><br />
        <asp:GridView ID="gvCommunications" SkinID="gridview" runat="server"  
        DataKeyNames="CommunicationID" 
        DataSourceID="dsForGvCommunications" ondatabound="gvCommunications_DataBound" 
        onselectedindexchanged="gvCommunications_SelectedIndexChanged" 
        AllowPaging="True" PageSize="5">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="ContactName" HeaderText="Contact" 
                    SortExpression="ContactName" />
                <asp:BoundField DataField="JobPostingJobTitle" 
                    HeaderText="Position Applying" 
                    SortExpression="JobPostingJobTitle" />
                <asp:BoundField DataField="CommunicationDate" DataFormatString="{0:d}" 
                    HeaderText="Date of Communication" SortExpression="CommunicationDate" />
                <asp:BoundField DataField="CommunicationTypeDescription" 
                    HeaderText="Contact Via" SortExpression="CommunicationTypeDescription" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                            CommandName="Delete" onclientclick="return confirm('Permanently Delete?')" 
                            Text="Delete"></asp:LinkButton>
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
        <asp:SqlDataSource ID="dsForGvCommunications" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFCommunications] WHERE [CommunicationID] = @CommunicationID" 
        InsertCommand="INSERT INTO [JFCommunications] ([CommunicationJobPostingID], [CommunicationContactID], [CommunicationDate], [CommunicationNotes], [CommunicationTypeID], [CommunicationFollowUpRequired]) VALUES (@CommunicationJobPostingID, @CommunicationContactID, @CommunicationDate, @CommunicationNotes, @CommunicationTypeID, @CommunicationFollowUpRequired)" 
        
        SelectCommand="SELECT JFCommunications.CommunicationID, JFCommunications.CommunicationJobPostingID, 
        JFCommunications.CommunicationContactID, JFCommunications.CommunicationDate, JFCommunications.CommunicationNotes, 
        JFCommunications.CommunicationTypeID, JFCommunications.CommunicationFollowUpRequired, 
        JFCommunicationTypes.CommunicationTypeDescription, JFContacts.ContactName, JFJobPostings.JobPostingJobTitle, 
        JFCompanies.CompanyName FROM JFCommunications INNER JOIN JFCommunicationTypes ON 
        JFCommunications.CommunicationTypeID = JFCommunicationTypes.CommunicationTypeID INNER JOIN 
        JFContacts ON JFCommunications.CommunicationContactID = JFContacts.ContactID INNER JOIN JFJobPostings ON 
        JFCommunications.CommunicationJobPostingID = JFJobPostings.JobPostingID INNER JOIN JFCompanies ON 
        JFContacts.ContactCompanyID = JFCompanies.CompanyID AND 
        JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID"
         
        
        UpdateCommand="UPDATE [JFCommunications] SET [CommunicationJobPostingID] = @CommunicationJobPostingID, [CommunicationContactID] = @CommunicationContactID, [CommunicationDate] = @CommunicationDate, [CommunicationNotes] = @CommunicationNotes, [CommunicationTypeID] = @CommunicationTypeID, [CommunicationFollowUpRequired] = @CommunicationFollowUpRequired WHERE [CommunicationID] = @CommunicationID">
            <DeleteParameters>
                <asp:Parameter Name="CommunicationID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
                <asp:Parameter Name="CommunicationContactID" Type="Int32" />
                <asp:Parameter DbType="Date" Name="CommunicationDate" />
                <asp:Parameter Name="CommunicationNotes" Type="String" />
                <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
                <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
                <asp:Parameter Name="CommunicationContactID" Type="Int32" />
                <asp:Parameter DbType="Date" Name="CommunicationDate" />
                <asp:Parameter Name="CommunicationNotes" Type="String" />
                <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
                <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
                <asp:Parameter Name="CommunicationID" Type="Int32" />
            </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="dsCommunicationsQS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFCommunications] WHERE [CommunicationID] = @CommunicationID" 
        InsertCommand="INSERT INTO [JFCommunications] ([CommunicationJobPostingID], [CommunicationContactID], [CommunicationDate], [CommunicationNotes], [CommunicationTypeID], [CommunicationFollowUpRequired]) VALUES (@CommunicationJobPostingID, @CommunicationContactID, @CommunicationDate, @CommunicationNotes, @CommunicationTypeID, @CommunicationFollowUpRequired)" 
        SelectCommand="SELECT JFCommunications.CommunicationID, JFCommunications.CommunicationJobPostingID, 
        JFCommunications.CommunicationContactID, JFCommunications.CommunicationDate, 
        JFCommunications.CommunicationNotes, JFCommunications.CommunicationTypeID, 
        JFCommunications.CommunicationFollowUpRequired, JFCommunicationTypes.CommunicationTypeDescription, 
        JFContacts.ContactName, JFJobPostings.JobPostingJobTitle FROM JFCommunications INNER JOIN 
        JFCommunicationTypes ON JFCommunications.CommunicationTypeID = JFCommunicationTypes.CommunicationTypeID 
        INNER JOIN JFContacts ON JFCommunications.CommunicationContactID = JFContacts.ContactID INNER JOIN 
        JFJobPostings ON JFCommunications.CommunicationJobPostingID = JFJobPostings.JobPostingID 
        WHERE (JFCommunications.CommunicationJobPostingID = @CommunicationJobPostingID)" 

        UpdateCommand="UPDATE [JFCommunications] SET [CommunicationJobPostingID] = @CommunicationJobPostingID, [CommunicationContactID] = @CommunicationContactID, [CommunicationDate] = @CommunicationDate, [CommunicationNotes] = @CommunicationNotes, [CommunicationTypeID] = @CommunicationTypeID, [CommunicationFollowUpRequired] = @CommunicationFollowUpRequired WHERE [CommunicationID] = @CommunicationID">
        <DeleteParameters>
            <asp:Parameter Name="CommunicationID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
            <asp:Parameter Name="CommunicationContactID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="CommunicationDate" />
            <asp:Parameter Name="CommunicationNotes" Type="String" />
            <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
            <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="CommunicationJobPostingID" 
                QueryStringField="commid" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
            <asp:Parameter Name="CommunicationContactID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="CommunicationDate" />
            <asp:Parameter Name="CommunicationNotes" Type="String" />
            <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
            <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
            <asp:Parameter Name="CommunicationID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="dsCommunicationsQSContacts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFCommunications] WHERE [CommunicationID] = @CommunicationID" 
        InsertCommand="INSERT INTO [JFCommunications] ([CommunicationJobPostingID], [CommunicationContactID], [CommunicationDate], [CommunicationNotes], [CommunicationTypeID], [CommunicationFollowUpRequired]) VALUES (@CommunicationJobPostingID, @CommunicationContactID, @CommunicationDate, @CommunicationNotes, @CommunicationTypeID, @CommunicationFollowUpRequired)" 
        SelectCommand="SELECT JFCommunications.CommunicationID, JFCommunications.CommunicationJobPostingID, JFCommunications.CommunicationContactID, JFCommunications.CommunicationDate, JFCommunications.CommunicationNotes, JFCommunications.CommunicationTypeID, JFCommunications.CommunicationFollowUpRequired, JFCommunicationTypes.CommunicationTypeDescription, JFContacts.ContactName, JFJobPostings.JobPostingJobTitle FROM JFCommunications INNER JOIN JFCommunicationTypes ON JFCommunications.CommunicationTypeID = JFCommunicationTypes.CommunicationTypeID INNER JOIN JFContacts ON JFCommunications.CommunicationContactID = JFContacts.ContactID INNER JOIN JFJobPostings ON JFCommunications.CommunicationJobPostingID = JFJobPostings.JobPostingID WHERE (JFCommunications.CommunicationContactID = @CommunicationContactID)" 
        UpdateCommand="UPDATE [JFCommunications] SET [CommunicationJobPostingID] = @CommunicationJobPostingID, [CommunicationContactID] = @CommunicationContactID, [CommunicationDate] = @CommunicationDate, [CommunicationNotes] = @CommunicationNotes, [CommunicationTypeID] = @CommunicationTypeID, [CommunicationFollowUpRequired] = @CommunicationFollowUpRequired WHERE [CommunicationID] = @CommunicationID">
        <DeleteParameters>
            <asp:Parameter Name="CommunicationID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
            <asp:Parameter Name="CommunicationContactID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="CommunicationDate" />
            <asp:Parameter Name="CommunicationNotes" Type="String" />
            <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
            <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="CommunicationContactID" 
                QueryStringField="contid" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
            <asp:Parameter Name="CommunicationContactID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="CommunicationDate" />
            <asp:Parameter Name="CommunicationNotes" Type="String" />
            <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
            <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
            <asp:Parameter Name="CommunicationID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:SqlDataSource ID="dsCommunicationsByJobPostings" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        SelectCommand="SELECT JFCommunications.CommunicationID, JFCommunications.CommunicationJobPostingID, JFCommunications.CommunicationContactID, JFCommunications.CommunicationDate, JFCommunications.CommunicationNotes, JFCommunications.CommunicationTypeID, JFCommunications.CommunicationFollowUpRequired, JFJobPostings.JobPostingJobTitle, JFContacts.ContactName, JFCommunicationTypes.CommunicationTypeDescription FROM JFCommunications INNER JOIN JFJobPostings ON JFCommunications.CommunicationJobPostingID = JFJobPostings.JobPostingID INNER JOIN JFContacts ON JFCommunications.CommunicationContactID = JFContacts.ContactID INNER JOIN JFCommunicationTypes ON JFCommunications.CommunicationTypeID = JFCommunicationTypes.CommunicationTypeID WHERE (JFCommunications.CommunicationJobPostingID = @CommunicationJobPostingID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlJobPostings" 
                Name="CommunicationJobPostingID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
</asp:View><%--end vwGridViewCommunications--%>
</center>
    <center>
<asp:View ID="vwDetailsViewSelectedCommunication" runat="server">


    <asp:DetailsView ID="dvSelectedCommunication" SkinID="detailsview" runat="server" DataSourceID="dsSelectedCommunication" 
         DataKeyNames="CommunicationID" EnableViewState="False" 
        ondatabound="dvSelectedCommunication_DataBound">
        <Fields>
            <asp:TemplateField HeaderText="Contact" SortExpression="ContactName">
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("ContactName") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="ddlText" 
                        DataValueField="ContactID" 
                        SelectedValue='<%# Bind("CommunicationContactID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Contact-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="* Choose a Contact" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("ContactName") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        
                        SelectCommand="SELECT JFContacts.ContactID, JFContacts.ContactName, JFContacts.ContactCompanyID, JFCompanies.CompanyName, JFContacts.ContactName + ' - ' +  JFCompanies.CompanyName AS ddlText FROM JFContacts INNER JOIN JFCompanies ON JFContacts.ContactCompanyID = JFCompanies.CompanyID ORDER BY JFContacts.ContactName">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="ddlText" 
                        DataValueField="ContactID" 
                        SelectedValue='<%# Bind("CommunicationContactID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Contact-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="* Choose a Contact" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("ContactName") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        
                        SelectCommand="SELECT JFContacts.ContactID, JFContacts.ContactName, JFContacts.ContactCompanyID, JFCompanies.CompanyName, JFContacts.ContactName + ' - ' +  JFCompanies.CompanyName AS ddlText FROM JFContacts INNER JOIN JFCompanies ON JFContacts.ContactCompanyID = JFCompanies.CompanyID ORDER BY JFContacts.ContactName">
                    </asp:SqlDataSource>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Follow Up Required" 
                SortExpression="CommunicationFollowUpRequired">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("CommunicationFollowUpRequired") %>' Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("CommunicationFollowUpRequired") %>' />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("CommunicationFollowUpRequired") %>' />
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Position Applying" 
                SortExpression="JobPostingJobTitle">
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("JobPostingJobTitle") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" 
                        DataSourceID="SqlDataSource3" DataTextField="ddlText" 
                        DataValueField="JobPostingID" 
                        SelectedValue='<%# Bind("CommunicationJobPostingID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Job Posting-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="DropDownList3" ErrorMessage="* Choose a Job Posting" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("JobPostingJobTitle") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, JFJobPostings.JobPostingCompanyID, JFCompanies.CompanyName, JFJobPostings.JobPostingJobTitle + ' - ' + JFCompanies.CompanyName AS ddlText FROM JFJobPostings INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" 
                        DataSourceID="SqlDataSource3" DataTextField="ddlText" 
                        DataValueField="JobPostingID" 
                        SelectedValue='<%# Bind("CommunicationJobPostingID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Job Posting-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="DropDownList3" ErrorMessage="* Choose a Job Posting" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("JobPostingJobTitle") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, JFJobPostings.JobPostingCompanyID, JFCompanies.CompanyName, JFJobPostings.JobPostingJobTitle + ' - ' + JFCompanies.CompanyName AS ddlText FROM JFJobPostings INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID">
                    </asp:SqlDataSource>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date of Communication" 
                SortExpression="CommunicationDate">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Bind("CommunicationDate", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" 
                        Text='<%# Bind("CommunicationDate", "{0:d}") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" 
                        TargetControlID="TextBox1">
                    </asp:CalendarExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" 
                        Text='<%# Bind("CommunicationDate", "{0:d}") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" 
                        TargetControlID="TextBox1">
                    </asp:CalendarExtender>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Contact Via" 
                SortExpression="CommunicationTypeDescription">
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" 
                        Text='<%# Bind("CommunicationTypeDescription") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList4" runat="server" 
                        DataSourceID="SqlDataSource4" DataTextField="CommunicationTypeDescription" 
                        DataValueField="CommunicationTypeID" 
                        SelectedValue='<%# Bind("CommunicationTypeID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Contact Method-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="DropDownList4" ErrorMessage="* Choose a Contact Method" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("CommunicationTypeDescription") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [CommunicationTypeDescription], [CommunicationTypeID] FROM [JFCommunicationTypes]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList4" runat="server" 
                        DataSourceID="SqlDataSource4" DataTextField="CommunicationTypeDescription" 
                        DataValueField="CommunicationTypeID" 
                        SelectedValue='<%# Bind("CommunicationTypeID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Contact Method-]</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="DropDownList4" ErrorMessage="* Choose a Contact Method" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("CommunicationTypeDescription") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [CommunicationTypeDescription], [CommunicationTypeID] FROM [JFCommunicationTypes]">
                    </asp:SqlDataSource>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Notes" SortExpression="CommunicationNotes">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("CommunicationNotes") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="tbCommunicationNotes" runat="server" Rows="5" 
                        Text='<%# Bind("CommunicationNotes") %>' TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbCommunicationNotes" runat="server" Rows="5" 
                        Text='<%# Bind("CommunicationNotes") %>' TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Edit"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="New" Text="New"></asp:LinkButton>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Update" onclick="LinkButton1_Click1" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Cancel" onclick="LinkButton2_Click1"></asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Insert" onclick="LinkButton1_Click" Text="Insert"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" onclick="LinkButton2_Click" Text="Cancel"></asp:LinkButton>
                </InsertItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    <br />
    <asp:SqlDataSource ID="dsSelectedCommunication" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFCommunications] WHERE [CommunicationID] = @CommunicationID" 
        InsertCommand="INSERT INTO [JFCommunications] ([CommunicationJobPostingID], [CommunicationContactID], [CommunicationDate], [CommunicationNotes], [CommunicationTypeID], [CommunicationFollowUpRequired]) VALUES (@CommunicationJobPostingID, @CommunicationContactID, @CommunicationDate, @CommunicationNotes, @CommunicationTypeID, @CommunicationFollowUpRequired)" 
        SelectCommand="SELECT JFCommunications.CommunicationID, JFCommunications.CommunicationJobPostingID, JFCommunications.CommunicationContactID, JFCommunications.CommunicationDate, JFCommunications.CommunicationNotes, JFCommunications.CommunicationTypeID, JFCommunications.CommunicationFollowUpRequired, JFContacts.ContactName, JFJobPostings.JobPostingJobTitle, JFCommunicationTypes.CommunicationTypeDescription FROM JFCommunications INNER JOIN JFContacts ON JFCommunications.CommunicationContactID = JFContacts.ContactID INNER JOIN JFJobPostings ON JFCommunications.CommunicationJobPostingID = JFJobPostings.JobPostingID INNER JOIN JFCommunicationTypes ON JFCommunications.CommunicationTypeID = JFCommunicationTypes.CommunicationTypeID  WHERE (JFCommunications.CommunicationID = @CommunicationID)" 
        
        UpdateCommand="UPDATE [JFCommunications] SET [CommunicationJobPostingID] = @CommunicationJobPostingID, [CommunicationContactID] = @CommunicationContactID, [CommunicationDate] = @CommunicationDate, [CommunicationNotes] = @CommunicationNotes, [CommunicationTypeID] = @CommunicationTypeID, [CommunicationFollowUpRequired] = @CommunicationFollowUpRequired WHERE [CommunicationID] = @CommunicationID" 
        oninserted="dsSelectedCommunication_Inserted" 
        onupdated="dsSelectedCommunication_Updated">
        <DeleteParameters>
            <asp:Parameter Name="CommunicationID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
            <asp:Parameter Name="CommunicationContactID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="CommunicationDate" />
            <asp:Parameter Name="CommunicationNotes" Type="String" />
            <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
            <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCommunications" Name="CommunicationID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CommunicationJobPostingID" Type="Int32" />
            <asp:Parameter Name="CommunicationContactID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="CommunicationDate" />
            <asp:Parameter Name="CommunicationNotes" Type="String" />
            <asp:Parameter Name="CommunicationTypeID" Type="Int32" />
            <asp:Parameter Name="CommunicationFollowUpRequired" Type="Boolean" />
            <asp:Parameter Name="CommunicationID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:LinkButton ID="btnBackToCommunications" runat="server" Font-Bold="True" 
        ForeColor="Black" onclick="btnBackToCommunications_Click">Back To Communications</asp:LinkButton>
</asp:View><%--end vwDetailsViewSelectedCommunication--%>
        </asp:MultiView>
</center>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphSideLeft" runat="Server">
</asp:Content>
