<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="JobPostings.aspx.cs" Inherits="JobPostings" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {
            $('#cphMain_dvSelectedJobPosting_tbJobDescription').maxlength({

                events: [], // Array of events to be triggerd   

                maxCharacters: 500, // Characters limit  
                max: 4000,
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




        <script type="text/javascript">
            $(document).ready(function () {
                $('#cphMain_dvSelectedJobPosting_tbJobPostingNotes').maxlength({

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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMenu" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphBannerWrapper" Runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server">
    </asp:ToolkitScriptManager>

    <center>
    <asp:MultiView ID="mvJobPostings" runat="server" ActiveViewIndex="0">
    
        <asp:View ID="vwGridViewJobPostings" runat="server">
        

        <br />

    <asp:RadioButtonList ID="rblJobPostingStatuses" runat="server" Font-Bold="true"
    ForeColor="Black" 
        onselectedindexchanged="rblJobPostingStatuses_SelectedIndexChanged" 
        AutoPostBack="True">
    <asp:ListItem Value="1">- Show Inactive Job Postings</asp:ListItem>
    <asp:ListItem Value="2">- Show Active Job Postings</asp:ListItem>
    </asp:RadioButtonList>

        
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <center>
    <asp:LinkButton ID="btnAddNewPosting" runat="server" Font-Bold="True" 
        ForeColor="Black" onclick="btnAddNewPosting_Click" 
            onprerender="AdminControl_PreRender">Add New Job Posting</asp:LinkButton>
    </center>


    
    <asp:GridView ID="gvJobPostings" SkinID="gridview" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="JobPostingID" DataSourceID="dsActiveJobPostings" 
        onselectedindexchanged="gvJobPostings_SelectedIndexChanged" 
                ondatabound="gvJobPostings_DataBound" PageSize="5">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Select" Text="Select" onclick="LinkButton2_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="JobPostingJobTitle" HeaderText="Job Title" 
                SortExpression="JobPostingJobTitle" />
            <asp:BoundField DataField="CompanyName" HeaderText="Company" 
                SortExpression="CompanyName" />
            <asp:TemplateField HeaderText="View Communications">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("JobPostingID", "~/communications.aspx?commid={0}") %>'>View Communications</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="JobPostingStartDate" HeaderText="Date Posted" 
                SortExpression="JobPostingStartDate" DataFormatString="{0:d}" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Delete" onclientclick="return confirm('Are you sure?')" 
                        Text="Change  Status"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dsActiveJobPostings" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="UPDATE [JFJobPostings] SET JobPostingStatusID=9 WHERE [JobPostingID] = @JobPostingID" 

        InsertCommand="INSERT INTO [JFJobPostings] ([JobPostingJobTitle], [JobPostingDescription], 
        [JobPostingSource], [JobPostingURL], [JobPostingCompanyID], [JobPostingStartDate], 
        [JobPostingApplicationDeadlineDate], [JobPostingStatusID], [JobPostingNotes]) 
        VALUES (@JobPostingJobTitle, @JobPostingDescription, @JobPostingSource, @JobPostingURL, 
        @JobPostingCompanyID, @JobPostingStartDate, @JobPostingApplicationDeadlineDate, 
        @JobPostingStatusID, @JobPostingNotes)" 

        SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, 
        JFJobPostings.JobPostingCompanyID, JFJobPostings.JobPostingStartDate, JFJobPostings.JobPostingStatusID, 
        JFJobPostingsStatuses.JobPostingStatusName, JFCompanies.CompanyName FROM JFJobPostings 
        INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID 
        INNER JOIN JFJobPostingsStatuses ON JFJobPostings.JobPostingStatusID = 
        JFJobPostingsStatuses.JobPostingStatusID 
        WHERE (JFJobPostings.JobPostingStatusID = @JobPostingStatusID) OR 
        (JFJobPostings.JobPostingStatusID = @JobPostingStatusID2)" 
        
        UpdateCommand="UPDATE [JFJobPostings] SET [JobPostingJobTitle] = @JobPostingJobTitle, 
        [JobPostingDescription] = @JobPostingDescription, [JobPostingSource] = @JobPostingSource, 
        [JobPostingURL] = @JobPostingURL, [JobPostingCompanyID] = @JobPostingCompanyID, 
        [JobPostingStartDate] = @JobPostingStartDate, 
        [JobPostingApplicationDeadlineDate] = @JobPostingApplicationDeadlineDate, 
        [JobPostingStatusID] = @JobPostingStatusID, [JobPostingNotes] = @JobPostingNotes 
        WHERE [JobPostingID] = @JobPostingID">
        <DeleteParameters>
            <asp:Parameter Name="JobPostingID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="JobPostingJobTitle" Type="String" />
            <asp:Parameter Name="JobPostingDescription" Type="String" />
            <asp:Parameter Name="JobPostingSource" Type="String" />
            <asp:Parameter Name="JobPostingURL" Type="String" />
            <asp:Parameter Name="JobPostingCompanyID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="JobPostingStartDate" />
            <asp:Parameter DbType="Date" Name="JobPostingApplicationDeadlineDate" />
            <asp:Parameter Name="JobPostingStatusID" Type="Int32" />
            <asp:Parameter Name="JobPostingNotes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="JobPostingStatusID" />
            <asp:Parameter DefaultValue="2" Name="JobPostingStatusID2" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="JobPostingJobTitle" Type="String" />
            <asp:Parameter Name="JobPostingDescription" Type="String" />
            <asp:Parameter Name="JobPostingSource" Type="String" />
            <asp:Parameter Name="JobPostingURL" Type="String" />
            <asp:Parameter Name="JobPostingCompanyID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="JobPostingStartDate" />
            <asp:Parameter DbType="Date" Name="JobPostingApplicationDeadlineDate" />
            <asp:Parameter Name="JobPostingStatusID" Type="Int32" />
            <asp:Parameter Name="JobPostingNotes" Type="String" />
            <asp:Parameter Name="JobPostingID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
            <asp:LinkButton ID="btnBackToCompanies" runat="server" Font-Bold="True" 
                ForeColor="Black" onclick="btnBackToComapnies_Click" Visible="False">Back To Companies</asp:LinkButton>
    <br />
    <asp:SqlDataSource ID="dsInactiveJobPostings" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="UPDATE  [JFJobPostings] SET JobPostingStatusID=1 WHERE [JobPostingID] = @JobPostingID" 
        InsertCommand="INSERT INTO [JFJobPostings] ([JobPostingJobTitle], [JobPostingCompanyID], [JobPostingStartDate], [JobPostingStatusID]) VALUES (@JobPostingJobTitle, @JobPostingCompanyID, @JobPostingStartDate, @JobPostingStatusID)" 
        SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, JFJobPostings.JobPostingCompanyID, JFJobPostings.JobPostingStartDate, JFJobPostings.JobPostingStatusID, JFCompanies.CompanyName, JFJobPostingsStatuses.JobPostingStatusName FROM JFJobPostings INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID INNER JOIN JFJobPostingsStatuses ON JFJobPostings.JobPostingStatusID = JFJobPostingsStatuses.JobPostingStatusID WHERE (JFJobPostings.JobPostingStatusID IN (3, 4, 9))" 
        
        UpdateCommand="UPDATE [JFJobPostings] SET [JobPostingJobTitle] = @JobPostingJobTitle, [JobPostingCompanyID] = @JobPostingCompanyID, [JobPostingStartDate] = @JobPostingStartDate, [JobPostingStatusID] = @JobPostingStatusID WHERE [JobPostingID] = @JobPostingID">
        <DeleteParameters>
            <asp:Parameter Name="JobPostingID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="JobPostingJobTitle" Type="String" />
            <asp:Parameter Name="JobPostingCompanyID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="JobPostingStartDate" />
            <asp:Parameter Name="JobPostingStatusID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="JobPostingStatusID" Type="Int32" />
            <asp:Parameter DefaultValue="4" Name="JobPostingStatusID2" Type="Int32" />
            <asp:Parameter DefaultValue="9" Name="JobPostingStatusID3" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="JobPostingJobTitle" Type="String" />
            <asp:Parameter Name="JobPostingCompanyID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="JobPostingStartDate" />
            <asp:Parameter Name="JobPostingStatusID" Type="Int32" />
            <asp:Parameter Name="JobPostingID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

            <br />


<asp:SqlDataSource ID="dsActiveJobPostingsQS" runat="server" 
                ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                DeleteCommand="DELETE FROM [JFJobPostings] WHERE [JobPostingID] = @JobPostingID" 
                InsertCommand="INSERT INTO [JFJobPostings] ([JobPostingJobTitle], [JobPostingStartDate]) VALUES (@JobPostingJobTitle, @JobPostingStartDate)" 
                SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, JFJobPostings.JobPostingStartDate, JFCompanies.CompanyName FROM JFJobPostings INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID WHERE (JFJobPostings.JobPostingCompanyID = @JobPostingCompanyID) AND (JFJobPostings.JobPostingStatusID = @JobPostingStatusID) ORDER BY JFJobPostings.JobPostingStartDate" 
                
                UpdateCommand="UPDATE [JFJobPostings] SET [JobPostingJobTitle] = @JobPostingJobTitle, [JobPostingStartDate] = @JobPostingStartDate WHERE [JobPostingID] = @JobPostingID">
                <DeleteParameters>
                    <asp:Parameter Name="JobPostingID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="JobPostingJobTitle" Type="String" />
                    <asp:Parameter Name="JobPostingStartDate" DbType="Date" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="JobPostingCompanyID" QueryStringField="jpid" 
                        Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="JobPostingStatusID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="JobPostingJobTitle" Type="String" />
                    <asp:Parameter Name="JobPostingStartDate" DbType="Date" />
                    <asp:Parameter Name="JobPostingID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
 </asp:View><%--end vwGridViewJobPostings--%>
 </center>
<center>
 <asp:View ID="vwDetailsViewSelectedJobPosting" runat="server">
        
   
    <br /><br />

    <asp:DetailsView ID="dvSelectedJobPosting" skinId="detailsview" runat="server"  
        AutoGenerateRows="False" DataKeyNames="JobPostingID" 
        DataSourceID="dsSelectedJobPosting" EnableViewState="False" 
        ondatabound="dvSelectedJobPosting_DataBound"> 
        <Fields>
            <asp:TemplateField HeaderText="Job Title" SortExpression="JobPostingJobTitle">
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("JobPostingJobTitle") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="tbJobTitle" runat="server" 
                        Text='<%# Bind("JobPostingJobTitle") %>'></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="tbJobTitle" ErrorMessage="* Enter a Job Title" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" 
                        Text='<%# Eval("JobPostingJobTitle") %>'></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbJobTitle" runat="server" 
                        Text='<%# Bind("JobPostingJobTitle") %>'></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="tbJobTitle" ErrorMessage="* Enter a Job Title" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" 
                        Text='<%# Eval("JobPostingJobTitle") %>'></asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="JobPostingStatusID">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="JobPostingStatusName" 
                        DataValueField="JobPostingStatusID" 
                        SelectedValue='<%# Bind("JobPostingStatusID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Status-]</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="* Choose Status" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1"></asp:RequiredFieldValidator>
                    &nbsp;<br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [JobPostingStatusID], [JobPostingStatusName] FROM [JFJobPostingsStatuses]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <br />
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="JobPostingStatusName" 
                        DataValueField="JobPostingStatusID" 
                        SelectedValue='<%# Bind("JobPostingStatusID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Status-]</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="* Choose Status" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [JobPostingStatusID], [JobPostingStatusName] FROM [JFJobPostingsStatuses]">
                    </asp:SqlDataSource>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Bind("JobPostingStatusName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Company" SortExpression="JobPostingCompanyID">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="CompanyName" 
                        DataValueField="CompanyID" 
                        SelectedValue='<%# Bind("JobPostingCompanyID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Company-]</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                    <asp:RequiredFieldValidator ID="rfvCompany" runat="server" 
                        ErrorMessage=" * Choose a Company" 
                        Text='<%# Eval("CompanyName") %>' ControlToValidate="DropDownList2" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black"></asp:RequiredFieldValidator>
                    &nbsp;
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [CompanyName], [CompanyID] FROM [JFCompanies]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="CompanyName" 
                        DataValueField="CompanyID" 
                        SelectedValue='<%# Bind("JobPostingCompanyID") %>' 
                        AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[-Choose Company-]</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCompany" runat="server" 
                        ControlToValidate="DropDownList2" ErrorMessage=" * Choose a Company" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black" InitialValue="-1" 
                        Text='<%# Eval("CompanyName") %>'></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
                        SelectCommand="SELECT [CompanyName], [CompanyID] FROM [JFCompanies]">
                    </asp:SqlDataSource>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Job Description" 
                SortExpression="JobPostingDescription">
                <EditItemTemplate>
                    <asp:TextBox ID="tbJobDescription" runat="server" 
                        Text='<%# Bind("JobPostingDescription") %>' TextMode="MultiLine" Rows="5"></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="tbJobDescription" ErrorMessage="* Enter a Descrption" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbJobDescription" runat="server" 
                        Text='<%# Bind("JobPostingDescription") %>' TextMode="MultiLine" Rows="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="tbJobDescription" ErrorMessage="* Enter a Descrption" 
                        Font-Bold="True" Font-Italic="True" ForeColor="Black"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="lblCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" 
                        Text='<%# Bind("JobPostingDescription") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Post Date" SortExpression="JobPostingStartDate">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" 
                        Text='<%# Bind("JobPostingStartDate", "{0:d}") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" 
                        TargetControlID="TextBox1"></asp:CalendarExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" 
                        Text='<%# Bind("JobPostingStartDate", "{0:d}") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" 
                        TargetControlID="TextBox1"></asp:CalendarExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# Bind("JobPostingStartDate", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Close Date" 
                SortExpression="JobPostingApplicationDeadlineDate">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" 
                        Text='<%# Bind("JobPostingApplicationDeadlineDate", "{0:d}") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox2_CalendarExtender" runat="server" 
                        TargetControlID="TextBox2"></asp:CalendarExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" 
                        Text='<%# Bind("JobPostingApplicationDeadlineDate", "{0:d}") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox2_CalendarExtender" runat="server" 
                        TargetControlID="TextBox2"></asp:CalendarExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" 
                        Text='<%# Bind("JobPostingApplicationDeadlineDate", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="JobPostingSource" 
                HeaderText="Source" SortExpression="JobPostingSource" />
            <asp:TemplateField HeaderText="Notes" SortExpression="JobPostingNotes">
                <EditItemTemplate>
                    <asp:TextBox ID="tbJobPostingNotes" runat="server" 
                        Text='<%# Bind("JobPostingNotes") %>' Rows="5" TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblMaxCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="tbJobPostingNotes" runat="server" 
                        Text='<%# Bind("JobPostingNotes") %>' Rows="5" TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblMaxCount" runat="server" CssClass="jqueryCount"></asp:Label>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("JobPostingNotes") %>'></asp:Label>
                </ItemTemplate>
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
                        CommandName="Cancel" onclick="LinkButton2_Click2" Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Insert" onclick="LinkButton1_Click" Text="Insert"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" onclick="LinkButton2_Click1" Text="Cancel"></asp:LinkButton>
                </InsertItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="dsSelectedJobPosting" runat="server" 
        ConnectionString="<%$ ConnectionStrings:JFConnectionString %>" 
        DeleteCommand="DELETE FROM [JFJobPostings] WHERE [JobPostingID] = @JobPostingID" 

        InsertCommand="INSERT INTO [JFJobPostings] ([JobPostingJobTitle], [JobPostingDescription], 
        [JobPostingSource], [JobPostingURL], [JobPostingCompanyID], [JobPostingStartDate], 
        [JobPostingApplicationDeadlineDate], [JobPostingStatusID], [JobPostingNotes]) 
        VALUES (@JobPostingJobTitle, @JobPostingDescription, @JobPostingSource, @JobPostingURL, 
        @JobPostingCompanyID, @JobPostingStartDate, @JobPostingApplicationDeadlineDate, 
        @JobPostingStatusID, @JobPostingNotes)" 
         
        SelectCommand="SELECT JFJobPostings.JobPostingID, JFJobPostings.JobPostingJobTitle, 
        JFJobPostings.JobPostingDescription, JFJobPostings.JobPostingSource, JFJobPostings.JobPostingURL, 
        JFJobPostings.JobPostingCompanyID, JFJobPostings.JobPostingStartDate, 
        JFJobPostings.JobPostingApplicationDeadlineDate, JFJobPostings.JobPostingStatusID, 
        JFJobPostings.JobPostingNotes, JFJobPostingsStatuses.JobPostingStatusName, JFCompanies.CompanyName 
        FROM JFJobPostings INNER JOIN JFCompanies ON JFJobPostings.JobPostingCompanyID = JFCompanies.CompanyID INNER JOIN JFJobPostingsStatuses ON JFJobPostings.JobPostingStatusID = JFJobPostingsStatuses.JobPostingStatusID WHERE (JFJobPostings.JobPostingID = @JobPostingID)" 
        
        
                UpdateCommand="UPDATE [JFJobPostings] SET [JobPostingJobTitle] = @JobPostingJobTitle, [JobPostingDescription] = @JobPostingDescription, [JobPostingSource] = @JobPostingSource, [JobPostingURL] = @JobPostingURL, [JobPostingCompanyID] = @JobPostingCompanyID, [JobPostingStartDate] = @JobPostingStartDate, [JobPostingApplicationDeadlineDate] = @JobPostingApplicationDeadlineDate, [JobPostingStatusID] = @JobPostingStatusID, [JobPostingNotes] = @JobPostingNotes WHERE [JobPostingID] = @JobPostingID" 
                oninserted="dsSelectedJobPosting_Inserted" 
        onupdated="dsSelectedJobPosting_Updated">
        <DeleteParameters>
            <asp:Parameter Name="JobPostingID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="JobPostingJobTitle" Type="String" />
            <asp:Parameter Name="JobPostingDescription" Type="String" />
            <asp:Parameter Name="JobPostingSource" Type="String" />
            <asp:Parameter Name="JobPostingURL" Type="String" />
            <asp:Parameter Name="JobPostingCompanyID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="JobPostingStartDate" />
            <asp:Parameter DbType="Date" Name="JobPostingApplicationDeadlineDate" />
            <asp:Parameter Name="JobPostingStatusID" Type="Int32" />
            <asp:Parameter Name="JobPostingNotes" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvJobPostings" Name="JobPostingID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="JobPostingJobTitle" Type="String" />
            <asp:Parameter Name="JobPostingDescription" Type="String" />
            <asp:Parameter Name="JobPostingSource" Type="String" />
            <asp:Parameter Name="JobPostingURL" Type="String" />
            <asp:Parameter Name="JobPostingCompanyID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="JobPostingStartDate" />
            <asp:Parameter DbType="Date" Name="JobPostingApplicationDeadlineDate" />
            <asp:Parameter Name="JobPostingStatusID" Type="Int32" />
            <asp:Parameter Name="JobPostingNotes" Type="String" />
            <asp:Parameter Name="JobPostingID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:LinkButton ID="btnBackToJobPostings" runat="server" 
                CausesValidation="False" Font-Bold="True" 
                ForeColor="Black" onclick="btnBackToJobPostings_Click">Back To Job Postings</asp:LinkButton>



 </asp:View><%--endvwDetailsViewSelectedJobPosting--%>
        </asp:MultiView>
        
 </center>

</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="cphSideLeft" Runat="Server">
</asp:Content>

