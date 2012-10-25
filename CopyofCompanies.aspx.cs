using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;//added for quick access to asyncfileupload
using System.Web.UI.HtmlControls;


public partial class Companies : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {

        //menu Controls
        HtmlControl cntrl = (HtmlControl)Master.FindControl("liCompanies");

        if (cntrl != null)
        {
            cntrl.Attributes["class"] = "current_page_item";
        }//end menu controls



    }
    protected void cbShowInactiveCompanies_CheckedChanged(object sender, EventArgs e)
    {
        //switch datasources based on wether or not the checkbox is checked4
        if (cbShowInactiveCompanies.Checked)
        {
            gvCompanies.DataSourceID = dsInactiveCompanies.ID;
        }
        else
        {
            gvCompanies.DataSourceID = dsActiveCompanies.ID;
        }
        gvCompanies.DataBind();
    }
    protected void gvCompanies_(object sender, EventArgs e)
    {

    }

    protected void gvCompanies_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvCompanies.ActiveViewIndex = 1;
    }

    protected void btnAddNewCompany_Click(object sender, EventArgs e)
    {
        //fvSelectedCompany.ChangeMode(DetailsViewMode.Insert);
        fvSelectedCompany.ChangeMode(FormViewMode.Insert);
        mvCompanies.ActiveViewIndex = 1;
    }
    protected void btnBackToCompanies_Click(object sender, EventArgs e)
    {
        mvCompanies.ActiveViewIndex = 0;
    }
    //protected void dsSelectedCompany_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    //{
    //    //switch back to the GV
    //    mvCompanies.ActiveViewIndex = 0;

    //     //update the GV
    //    gvCompanies.DataBind();
    //}

    //protected void dsSelectedCompany_Updated(object sender, SqlDataSourceStatusEventArgs e)
    //{

    //    //switch back to the GV
    //    mvCompanies.ActiveViewIndex = 0;

    //    gvCompanies.DataBind();//update the GV
    //}
    protected void AsyncFileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        #region LOGO UPLOAD

        //find the control in the detailsview
        AsyncFileUpload afuLogo = (AsyncFileUpload)fvSelectedCompany.FindControl
            ("AsyncFileUpload1");

        //generate a new unique image name
          //get the original filename for its file extension
        string imageName = afuLogo.FileName;//tells u the name of the filename they are uploading

        //get the extension
        string ext = imageName.Substring(imageName.LastIndexOf("."));

        //create a random unique filename (use GUID)
          //GUID creates a unique value, then tack on the extension
        string newImageName = Guid.NewGuid().ToString() + ext;

        //save the image to the students images folder using the new name
        afuLogo.SaveAs(Server.MapPath("~/images/" +
            newImageName));

        #endregion

        //When the record above is inserted or uploaded, we will need the
          //new filename to be used in the CompanyLogo field.
        Session["newImage"] = newImageName;
    }
    protected void dsSelectedCompany_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        //right before this really does get inserted, we need to make sure the
        //appropriate pictureURL value is included.

        //check to see if the image is in session and if it is use it for pictureURL
        if (Session["newImage"] != null)
        {
            //use uploaded image name
            string imageName = Session["newImage"].ToString();

            //add the value to the insert command (available thru event args)
            e.Command.Parameters["@CompanyLogo"].Value = imageName;

            //remove the image from session variable
            Session["newImage"] = null;//removing the newImage from Session
        }
        else
        {
            //use our noImage image
            e.Command.Parameters["@CompanyLogo"].Value = "NoPhoto.jpg";
        }

    }//end dsSelectedCompany_Inserting
    protected void dsSelectedCompany_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {

        //check to see if the image is in session and if it is use it for pictureURL
        if (Session["newImage"] != null)
        {
            //use uploaded image name
            string imageName = Session["newImage"].ToString();

            //add the value to the insert command (available thru event args)
            e.Command.Parameters["@CompanyLogo"].Value = imageName;

            //remove the image from session variable
            Session["newImage"] = null;//removing the newImage from Session
        }//end if
        else
        {
            //if there was an image uploaded on this editing of the record
            //then we used the same if as we did w inserting a record, but
            //in this case while editing the record if you wind up in this else
            //they have no uploaded a new image. We can assume they had a pictureURL
            //value before.
            //If we skip this step, then the "empty string" will be passed.
            //So if we want to let them keep their old pic, we need to  find
            //that value and reset it.

            //grab what is currently being used and re-use it
            DataClassesDataContext ctx = new DataClassesDataContext();

            string currentImage = (from co in ctx.JFCompanies
                                   where co.CompanyID.ToString() ==
                                   gvCompanies.SelectedValue.ToString()
                                   select co.CompanyLogo).Single();

            //assign back to the pictureURL
            //@ calls on the parametes of the command. we are calling on the update command
            e.Command.Parameters["@CompanyLogo"].Value = currentImage;

        }


    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        mvCompanies.ActiveViewIndex = 0;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        mvCompanies.ActiveViewIndex = 0;
    }

    //secure the LAST COLUMN of the Gridview
    protected void gvCompanies_DataBound(object sender, EventArgs e)
    {
        //hide the change status if the user is not an admin
        if (!User.IsInRole("admin"))
        {
            //index is 0 base
            gvCompanies.Columns[gvCompanies.Columns.Count - 1].Visible = false;
        }
    }

    ////secure the LAST ROW of the DetailsView
    //protected void dvSelectedCompany_DataBound(object sender, EventArgs e)
    //{
    //    if (!User.IsInRole("admin"))
    //    {
    //       //dvSelectedCompany.Rows[dvSelectedCompany.Rows.Count - 1].Visible = false; 
            
    //    }
    //}

    //*********SECURE ADMIN BUTTONS OUTSIDE OF CONTROLS*********
       //and inside of a FV/ListView/datalist
    protected void AdminControl_PreRender(object sender, EventArgs e)
    {
        //connect this to the PRE RENDER event of each control that u want to hide individually
            //(not used with the gv or dv)
        if (!User.IsInRole("admin"))
        {//cast this object to an control

            ((Control)sender).Visible = false;
        }

        //FOR MULTI USER, YOU CAN ADD THE USER TO A ROLE (CREATE THE ROLE IN THE WSAT i.e. RegisteredUser) AND
          //CHECK THAT THE ROLE AS WELL AS THE ADMIN

        //additionally you will need to add the user to this role in ur create user wizard event handler
         //(see ASP2 - createUserWizard)

        //
        //if (!User.IsInRole("admin") || !User.IsInRole("registeredUser"))
        //{
        //    ((Control)sender).Visible = false;
        //}
    }

    protected void dsFVSelectedCompany_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {

        //check to see if the image is in session and if it is use it for pictureURL
        if (Session["newImage"] != null)
        {
            //use uploaded image name
            string imageName = Session["newImage"].ToString();

            //add the value to the insert command (available thru event args)
            e.Command.Parameters["@CompanyLogo"].Value = imageName;

            //remove the image from session variable
            Session["newImage"] = null;//removing the newImage from Session
        }//end if
        else
        {
            //if there was an image uploaded on this editing of the record
            //then we used the same if as we did w inserting a record, but
            //in this case while editing the record if you wind up in this else
            //they have no uploaded a new image. We can assume they had a pictureURL
            //value before.
            //If we skip this step, then the "empty string" will be passed.
            //So if we want to let them keep their old pic, we need to  find
            //that value and reset it.

            //grab what is currently being used and re-use it
            DataClassesDataContext ctx = new DataClassesDataContext();

            string currentImage = (from co in ctx.JFCompanies
                                   where co.CompanyID.ToString() ==
                                   gvCompanies.SelectedValue.ToString()
                                   select co.CompanyLogo).Single();

            //assign back to the pictureURL
            //@ calls on the parametes of the command. we are calling on the update command
            e.Command.Parameters["@CompanyLogo"].Value = currentImage;

        }







    }
    protected void dsFVSelectedCompany_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //switch back to the GV
        mvCompanies.ActiveViewIndex = 0;

        gvCompanies.DataBind();//update the GV

    }
    protected void dsFVSelectedCompany_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //switch back to the GV
        mvCompanies.ActiveViewIndex = 0;

        //update the GV
        gvCompanies.DataBind();

    }
    protected void dsFVSelectedCompany_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        //right before this really does get inserted, we need to make sure the
        //appropriate pictureURL value is included.

        //check to see if the image is in session and if it is use it for pictureURL
        if (Session["newImage"] != null)
        {
            //use uploaded image name
            string imageName = Session["newImage"].ToString();

            //add the value to the insert command (available thru event args)
            e.Command.Parameters["@CompanyLogo"].Value = imageName;

            //remove the image from session variable
            Session["newImage"] = null;//removing the newImage from Session
        }
        else
        {
            //use our noImage image
            e.Command.Parameters["@CompanyLogo"].Value = "NoPhoto.jpg";
        }




    }
    protected void UpdateCancelButton_Click(object sender, EventArgs e)
    {
        //if user hits cancel, send back to gridview
        mvCompanies.ActiveViewIndex = 0;
    }
    protected void InsertCancelButton_Click(object sender, EventArgs e)
    {
        //if user hits cancel in insert mode, send back to gridview
        mvCompanies.ActiveViewIndex = 0;
    }
}