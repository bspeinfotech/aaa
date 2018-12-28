using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EyeGlasses.BusinessLogicLayer.Common;
using EyeGlasses.BusinessLogicLayer;
using System.Text;
using System.Web.Helpers;
using Newtonsoft.Json;
using EyeGlasses.Models;
using System.Collections;
using System.Web.UI;

namespace EyeGlasses.Controllers
{
    public class BrandController : Controller
    {
        /* Created by   : Bhavesh Jadav
         * Created on   : 12-Feb-2018
         * Modified by  : Bhavesh Jadav
         * Modified on  : 28-Dec-2018
         * Description  : Get all products as per brand and filter products as per facet nagivation(filtration process).
         */

        #region Global variable declaration
        DataSet dsBrand = new DataSet();
        DataSet dsBrandProducts = new DataSet();
        DataSet dsfacetSearchdata = new DataSet();
        DataSet dsSearchdata = new DataSet();
        DataSet Wishlistproduct = new DataSet();

        public int newManufId = 0;

        List<string> filteredPrdIds = new List<string>();
        bool ismobile = false;
        bool iscatchupdate = false;
        string guid = "";
        string namecategory = "";

        bool isPrescription = false;
        bool isPolarized = false;
        bool isInStock = true;
        string sortby = "";

        string gender = "";
        string category = "";
        string frameType = "";
        string frameShape = "";
        string lensColor = "";
        string frameColor = "";

        public static int prdEnd = 12;

        public string strgooglegtag = "";


        #endregion

        /* Description : This is initial method when page load.
         * Input : manufacturerId -> It is brand id
         *         sort -> for sorting
         */
        public ActionResult Brand(string manufacturerId, string sort)
        {
            try
            {
                if (Request.QueryString["auto"] != null && Request.QueryString["auto"].ToString() == "1")
                {
                    #region Clear WebCache

                    if (Request.QueryString["IsAllProduct"] != null && Request.QueryString["IsAllProduct"].ToString() == "0")
                    {
                        // Clear all WebCache of single brand 
                        if (Request.QueryString["manufacturerId"] != null)
                        {
                            newManufId = Convert.ToInt32(Request.QueryString["manufacturerId"]);
                            System.Web.Helpers.WebCache.Remove("wcDsfacetSearchdata" + newManufId);
                            System.Web.Helpers.WebCache.Remove("wcDsSearchdata" + newManufId);
                            System.Web.Helpers.WebCache.Remove("wcDsBrandProducts" + newManufId);
                            System.Web.Helpers.WebCache.Remove("wcDsBrandProductsFiltered" + newManufId);
                        }
                    }
                    else
                    {
                        // Clear all WebCache of all brand 
                        var dsmanufacture = CommonBLL.GetCommonDataSet("Select ManufactureID from tb_Manufacture WHere StoreID=2 And Active=1 And Deleted=0");
                        for (int i = 0; i < dsmanufacture.Tables[0].Rows.Count; i++)
                        {
                            newManufId = Convert.ToInt32(dsmanufacture.Tables[0].Rows[i]["ManufactureID"]);
                            System.Web.Helpers.WebCache.Remove("wcDsfacetSearchdata" + newManufId);
                            System.Web.Helpers.WebCache.Remove("wcDsSearchdata" + newManufId);
                            System.Web.Helpers.WebCache.Remove("wcDsBrandProducts" + newManufId);
                            System.Web.Helpers.WebCache.Remove("wcDsBrandProductsFiltered" + newManufId);
                        }
                    }
                    #endregion
                }
                else
                {
                    #region Declaration

                    newManufId = Convert.ToInt32(manufacturerId);
                    string strSearchnamelist = "";
                    string strSearchvalue = "";

                    isPrescription = false;
                    isPolarized = false;
                    isInStock = true;
                    sortby = "bestseller";

                    gender = "";
                    category = "";
                    frameType = "";
                    frameShape = "";
                    lensColor = "";
                    frameColor = "";

                    ViewBag.Defaultscript = "";
                    ViewBag.BrandGender = "";
                    ViewBag.BrandCategory = "";
                    ViewBag.BrandFrameType = "";
                    ViewBag.BrandFrameShape = "";
                    ViewBag.BrandLensColor = "";
                    ViewBag.BrandFrameColor = "";
                    ViewBag.BrandSEOScript = "";

                    #endregion

                    #region Devices
                    string strUserAgent = Request.UserAgent.ToString().ToLower();
                    if (strUserAgent != null && strUserAgent.ToString().ToLower().IndexOf("ipad") <= -1)
                    {
                        if (Request.Browser.IsMobileDevice == true ||
                            strUserAgent.Contains("iphone") ||
                            strUserAgent.Contains("blackberry") ||
                            strUserAgent.Contains("mobile") ||
                            strUserAgent.Contains("windows ce") ||
                            strUserAgent.Contains("opera mini") ||
                            strUserAgent.Contains("palm"))
                        {
                            ismobile = true;
                            Session["ismobile"] = true;
                        }
                        else
                        {
                            Session["ismobile"] = false;
                        }
                    }
                    else
                    {
                        Session["ismobile"] = false;
                        ismobile = false;
                    }
                    #endregion

                    #region get Filter items
                    if (Request.Url.ToString().IndexOf("/" + newManufId.ToString() + "/") > -1 || Request.Url.ToString().ToLower().IndexOf("manufacturerid=" + newManufId.ToString() + "&") > -1)
                    {
                        try
                        {
                            string[] strSearchname = Request.Url.ToString().Replace("/" + newManufId.ToString() + "/", "/").Split("&".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

                            for (int i = 1; i < strSearchname.Length; i++)
                            {
                                string[] allSearch = strSearchname[i].Split("/".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
                                for (int j = 0; j < allSearch.Length; j++)
                                {
                                    if (allSearch[0].ToString().ToLower().IndexOf("prescription=") > -1)
                                    {
                                        isPrescription = Convert.ToBoolean(allSearch[0].ToString().Substring(allSearch[0].ToString().IndexOf("prescription=") + 13));
                                        if (isPrescription == true)
                                            ViewBag.Prescription = "checked=" + isPrescription + "";
                                    }
                                    else if (allSearch[0].ToString().ToLower().IndexOf("polarized=") > -1)
                                    {
                                        isPolarized = Convert.ToBoolean(allSearch[0].ToString().Substring(allSearch[0].ToString().IndexOf("ispolarized=") + 11));
                                        if (isPolarized == true)
                                            ViewBag.polarized = "checked=\"" + isPolarized + "\"";
                                    }
                                    else if (allSearch[0].ToString().ToLower().IndexOf("sort=") > -1)
                                    {
                                        sortby = allSearch[0].ToString().Substring(allSearch[0].ToString().IndexOf("sort=") + 5);
                                    }
                                    else if (allSearch[0].ToString().ToLower().IndexOf("instock=") > -1)
                                    {
                                        isInStock = Convert.ToBoolean(allSearch[0].ToString().Substring(allSearch[0].ToString().IndexOf("instock=") + 8));
                                        if (isInStock == true)
                                            ViewBag.InStock = "checked=\"" + isInStock + "\"";

                                        if (j == 1)
                                        {
                                            strSearchnamelist = allSearch[1].ToString();
                                        }
                                        else if (j == 2)
                                        {
                                            strSearchvalue = allSearch[2].ToString();
                                        }
                                    }
                                    else
                                    {
                                        if (j == 0)
                                        {
                                            strSearchnamelist = allSearch[0].ToString();
                                        }
                                        else if (j == 1)
                                        {
                                            strSearchvalue = allSearch[1].ToString();
                                        }
                                    }
                                }
                            }
                        }
                        catch
                        {

                        }
                    }

                    #endregion

                    if (Request.QueryString["catchupdate"] != null)
                    {
                        iscatchupdate = true;
                    }

                    GetDataFromWebCacheOrDatabase();

                    BindBrandDetails(newManufId);

                    ViewBag.InStock = "checked=\"" + isInStock + "\"";

                    if (isPrescription == true || isPolarized == true || isInStock == true)
                    {
                        Filteration(isPrescription, isPolarized, isInStock);
                    }

                    if ((strSearchnamelist != "" && strSearchvalue != ""))
                    {
                        #region get filter items data

                        string[] searchtypename = strSearchnamelist.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
                        string[] searchtypevalue = strSearchvalue.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

                        for (int i = 0; i < searchtypename.Length; i++)
                        {
                            if (searchtypename[i].ToString().ToLower() == "gender" && searchtypevalue.Length >= i)
                            {
                                gender = searchtypevalue[i].ToString();
                            }
                            else if (searchtypename[i].ToString().ToLower() == "category" && searchtypevalue.Length >= i)
                            {
                                category = searchtypevalue[i].ToString();
                            }
                            else if (searchtypename[i].ToString().ToLower() == "frametype" && searchtypevalue.Length >= i)
                            {
                                frameType = searchtypevalue[i].ToString();
                            }
                            else if (searchtypename[i].ToString().ToLower() == "frameshape" && searchtypevalue.Length >= i)
                            {
                                frameShape = searchtypevalue[i].ToString();
                            }
                            else if (searchtypename[i].ToString().ToLower() == "lenscolor" && searchtypevalue.Length >= i)
                            {
                                lensColor = searchtypevalue[i].ToString();
                            }
                            else if (searchtypename[i].ToString().ToLower() == "framecolor" && searchtypevalue.Length >= i)
                            {
                                frameColor = searchtypevalue[i].ToString();
                            }
                        }

                        if (searchtypename.Length > 1)
                            @ViewBag.Robots = "<meta name=\"robots\" content=\"noindex,nofollow\">";
                        else
                            @ViewBag.Robots = "";


                        #endregion

                        Int32 isMobile = 0;
                        if (Session["ismobile"] != null && Convert.ToBoolean(Session["ismobile"]) == true)
                        {
                            isMobile = 1;
                        }

                        FilterProductsByFacetData();
                    }
                    else
                        @ViewBag.filterCount = "less";

                    #region HTML design for Sorting

                    string strSortBy = "";

                    if (sortby != "")
                    {
                        ShortingProducts();

                        if (sortby == "a-z")
                            strSortBy += "<option value=\"a-z\" selected>A to Z</option>";
                        else
                            strSortBy += "<option value=\"a-z\" >A to Z</option>";

                        if (sortby == "z-a")
                            strSortBy += "<option value=\"z-a\" selected>Z to A</option>";
                        else
                            strSortBy += "<option value=\"z-a\" >Z to A</option>";

                        if (sortby == "high-low")
                            strSortBy += "<option value=\"high-low\" selected>Price: (High - Low)</option>";
                        else
                            strSortBy += "<option value=\"high-low\" >Price: (High - Low)</option>";

                        if (sortby == "low-high")
                            strSortBy += "<option value=\"low-high\" selected>Price: (Low - High)</option>";
                        else
                            strSortBy += "<option value=\"low-high\" >Price: (Low - High)</option>";

                        if (sortby == "bestseller")
                            strSortBy += "<option value=\"bestseller\" selected>Best Seller</option>";
                        else
                            strSortBy += "<option value=\"bestseller\" >Best Seller</option>";

                    }
                    else
                    {
                        strSortBy += "<option value=\"a-z\" selected>A to Z</option>";
                        strSortBy += "<option value=\"z-a\">Z to A</option>";
                        strSortBy += "<option value=\"high-low\">Price: (High - Low)</option>";
                        strSortBy += "<option value=\"low-high\">Price: (Low - High)</option>";
                        strSortBy += "<option value=\"bestseller\">Best Seller</option>";
                    }

                    ViewBag.SortBy = strSortBy;

                    #endregion

                    #region Facet design binding
                    StringBuilder SbFacetGender = new StringBuilder();
                    StringBuilder SbFacetGenderCount = new StringBuilder();
                    StringBuilder SbFacetCategory = new StringBuilder();
                    StringBuilder SbFacetCategoryCount = new StringBuilder();
                    StringBuilder SbFacetFrameType = new StringBuilder();
                    StringBuilder SbFacetFrameTypeCount = new StringBuilder();
                    StringBuilder SbFacetFrameShape = new StringBuilder();
                    StringBuilder SbFacetFrameShapeCount = new StringBuilder();
                    StringBuilder SbFacetLensColor = new StringBuilder();
                    StringBuilder SbFacetLensColorCount = new StringBuilder();
                    StringBuilder SbFacetFrameColor = new StringBuilder();
                    StringBuilder SbFacetFrameColorCount = new StringBuilder();

                    if (dsfacetSearchdata != null && dsfacetSearchdata.Tables.Count > 0)
                    {
                        ArrayList arr_FacetData = new ArrayList();
                        arr_FacetData = BindFacetData(gender, category, frameType, frameShape, lensColor, frameColor);

                        for (int i = 0; i < arr_FacetData.Count; i++)
                        {
                            if (arr_FacetData[i].ToString() != "")
                            {
                                int count = 0;
                                switch (i)
                                {
                                    case 0:
                                        ViewBag.BrandGender = arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0];

                                        Int32.TryParse(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1], out count);
                                        if (count > 3)
                                        {
                                            ViewBag.BrandGenderLoadMore = "<a id=\"moreGender\" href=\"javascript:void(0)\" class=\"font-default show-list\" onclick=\"showList(this)\">More Gender</a>";
                                        }
                                        else
                                        {
                                            ViewBag.BrandGenderLoadMore = "<a id=\"moreGender\" href=\"javascript:void(0)\" style=\"display:none\" class=\"font-default show-list\" onclick=\"showList(this)\">More Gender</a>";
                                        }
                                        break;

                                    case 1:
                                        ViewBag.BrandCategory = arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0];

                                        Int32.TryParse(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1], out count);
                                        if (count > 3)
                                        {
                                            ViewBag.BrandCategoryLoadMore = "<a id=\"moreCategory\" href=\"javascript:void(0)\" class=\"font-default show-list\" onclick=\"showList(this)\">More Categories</a>";
                                        }
                                        else
                                        {
                                            ViewBag.BrandBrandLoadMore = "<a id=\"moreCategory\" href=\"javascript:void(0)\" style=\"display:none\" class=\"font-default show-list\" onclick=\"showList(this)\">More Categories</a>";
                                        }
                                        break;

                                    case 2:
                                        ViewBag.BrandFrameType = arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0];

                                        Int32.TryParse(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1], out count);
                                        if (count > 3)
                                        {
                                            ViewBag.BrandFrameTypeLoadMore = "<a id=\"moreFrameType\" href=\"javascript:void(0)\" class=\"font-default show-list\" onclick=\"showList(this)\">More Types</a>";
                                        }
                                        else
                                        {
                                            ViewBag.BrandFrameTypeLoadMore = "<a id=\"moreFrameType\" href=\"javascript:void(0)\" style=\"display:none\" class=\"font-default show-list\" onclick=\"showList(this)\">More Types</a>";
                                        }
                                        break;

                                    case 3:
                                        ViewBag.BrandFrameShape = arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0];

                                        Int32.TryParse(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1], out count);
                                        if (count > 3)
                                        {
                                            ViewBag.BrandFrameShapeLoadMore = "<a id=\"moreFrameShape\" href=\"javascript:void(0)\" class=\"font-default show-list\" onclick=\"showList(this)\">More Frame Shapes</a>";
                                        }
                                        else
                                        {
                                            ViewBag.BrandFrameShapeLoadMore = "<a id=\"moreFrameShape\" href=\"javascript:void(0)\" style=\"display:none\" class=\"font-default show-list\" onclick=\"showList(this)\">More Frame Shapes</a>";
                                        }
                                        break;

                                    case 4:
                                        ViewBag.BrandLensColor = arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0];

                                        Int32.TryParse(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1], out count);
                                        if (count > 3)
                                        {
                                            ViewBag.BrandLensColorLoadMore = "<a id=\"moreLensColor\" href=\"javascript:void(0)\" class=\"font-default show-list\" onclick=\"showList(this)\">More Lens Colors</a>";
                                        }
                                        else
                                        {
                                            ViewBag.BrandLensColorLoadMore = "<a id=\"moreLensColor\" href=\"javascript:void(0)\" style=\"display:none\" class=\"font-default show-list\" onclick=\"showList(this)\">More Lens Colors</a>";
                                        }
                                        break;

                                    case 5:
                                        ViewBag.BrandFrameColor = arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0];

                                        Int32.TryParse(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1], out count);
                                        if (count > 3)
                                        {
                                            ViewBag.BrandFrameColorLoadMore = "<a id=\"moreFrameColor\" href=\"javascript:void(0)\" class=\"font-default show-list\" onclick=\"showList(this)\">More Colors</a>";
                                        }
                                        else
                                        {
                                            ViewBag.BrandFrameColorLoadMore = "<a id=\"moreFrameColor\" href=\"javascript:void(0)\" style=\"display:none\" class=\"font-default show-list\" onclick=\"showList(this)\">More Colors</a>";
                                        }
                                        break;
                                }
                            }
                        }
                    }
                    #endregion

                    HttpCookie cookie = Request.Cookies["productIds"];
                    String strCookieValue = "";
                    if (cookie != null)
                    {
                        strCookieValue = cookie.Value.ToString();
                    }

                    int Prdctcnt = 0;
                    string strGrid = "";
                    if (dsBrandProducts != null && dsBrandProducts.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
                    {
                        Prdctcnt = dsBrandProducts.Tables[0].Rows.Count;
                        strGrid = ProductBoxlist(dsBrandProducts, Prdctcnt, 0, 12, Wishlistproduct);   // start row = 0 , end row = 12
                    }
                    else
                    {
                        strGrid = "<div id=\"divgrid\"  style=\"padding-left: 15px;\">Sorry, No Result(s) Found.</div>";
                    }

                    string strRawurl1 = Request.RawUrl.ToString().ToLower();
                    string strRawurl = strRawurl1.Substring(strRawurl1.ToString().LastIndexOf("/"), strRawurl1.ToString().Length - strRawurl1.ToString().LastIndexOf("/"));
                    Int32 imobile = 0;
                    if (Session["ismobile"] != null && Convert.ToBoolean(Session["ismobile"]) == true)
                    {
                        imobile = 1;
                    }
                    guid = System.Guid.NewGuid().ToString();

                    #region script binding

                    if (strRawurl.IndexOf("?") > -1)
                    {
                        if (System.Web.HttpContext.Current.Session["parentId"] != null)
                        {
                            ViewBag.BrandListHTML = "firsttimeseturl('" + strRawurl.ToString().Substring(0, strRawurl.ToString().IndexOf("?")) + "','" + sortby + "'); getresults('" + dsBrandProducts.Tables[0].Rows.Count.ToString() + " Results','" + imobile + "','1'); $('#hdnguid').val('" + guid + "');$('#hdnparentid').val('" + System.Web.HttpContext.Current.Session["parentId"].ToString() + "');";
                        }
                        else
                        {
                            ViewBag.BrandListHTML = "firsttimeseturl('" + strRawurl.ToString().Substring(0, strRawurl.ToString().IndexOf("?")) + "','" + sortby + "'); getresults('" + dsBrandProducts.Tables[0].Rows.Count.ToString() + " Results','" + imobile + "','1'); $('#hdnguid').val('" + guid + "');$('#hdnparentid').val('0');";
                        }
                    }
                    else
                    {
                        if (System.Web.HttpContext.Current.Session["parentId"] != null)
                        {
                            ViewBag.BrandListHTML = "firsttimeseturl('" + Request.RawUrl.ToString() + "','" + sortby + "'); getresults('" + dsBrandProducts.Tables[0].Rows.Count.ToString() + " Results','" + imobile + "','1'); $('#hdnguid').val('" + guid + "');$('#hdnparentid').val('" + System.Web.HttpContext.Current.Session["parentId"].ToString() + "');";
                        }
                        else
                        {
                            ViewBag.BrandListHTML = "firsttimeseturl('" + Request.RawUrl.ToString() + "','" + sortby + "'); getresults('" + dsBrandProducts.Tables[0].Rows.Count.ToString() + " Results','" + imobile + "','1'); $('#hdnguid').val('" + guid + "');$('#hdnparentid').val('0');";
                        }

                    }
                    #endregion

                    ViewBag.ProductsCount = Prdctcnt.ToString() + " Results";
                    ViewBag.BrandListHTML = ViewBag.BrandListHTML.ToString() + "$('#Prdctcnt1').val('" + Prdctcnt + "');";
                    ViewBag.GridData = strGrid;
                    System.Web.HttpContext.Current.Session["parentId"] = "0";

                    #region Changed Page title, description and keywords
                    DataSet ds = new DataSet();
                    ds = CommonBLL.GetCommonDataSet("EXEC GuiGetPageTitleAndMetaTagByURL @URL='" + AppLogic.AppConfigs("LIVE_SERVER").ToString() + Server.UrlDecode(Request.RawUrl).Substring(1) + "'");
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        ViewBag.Metatitle = ds.Tables[0].Rows[0]["Page_title"].ToString();
                        ViewBag.MetaDescription = ds.Tables[0].Rows[0]["MetaDescription"].ToString();
                        ViewBag.MetaKeywords = ds.Tables[0].Rows[0]["MetaKeywords"].ToString();
                    }
                    #endregion
                }
            }
            catch (Exception ex)
            {
                CommonBLL.ErrorLog("Category", ex.Message, ex.StackTrace);
            }

            return View();
        }

        #region new Facet Navigation

        /* Description : This method get filter items and retrun HTML design for all filters and grid of prododucts.
         * Input  : facetData -> This object contains selected filter items 
         * Output : Retrun HTML design for all filters and grid of prododucts as a json object
         */
        public JsonResult GetAllfilteredData(FacetData facetData)
        {
            #region Declaretion

            string url = "";
            int tabid = 0;
            string guidenew = "";
            string strGrid = "";
            int Prdctcnt = 0;

            isPrescription = false;
            isPolarized = false;
            isInStock = true;
            sortby = "";

            gender = "";
            category = "";
            frameType = "";
            frameShape = "";
            lensColor = "";
            frameColor = "";

            StringBuilder SbFacetGender = new StringBuilder();
            StringBuilder SbFacetGendersCount = new StringBuilder();
            StringBuilder SbFacetCategory = new StringBuilder();
            StringBuilder SbFacetCategoryCount = new StringBuilder();
            StringBuilder SbFacetFrameType = new StringBuilder();
            StringBuilder SbFacetFrameTypesCount = new StringBuilder();
            StringBuilder SbFacetFrameShape = new StringBuilder();
            StringBuilder SbFacetFrameShapesCount = new StringBuilder();
            StringBuilder SbFacetLensColor = new StringBuilder();
            StringBuilder SbFacetLensColorCount = new StringBuilder();
            StringBuilder SbFacetFrameColor = new StringBuilder();
            StringBuilder SbFacetFrameColorCount = new StringBuilder();

            #endregion

            #region get parameters data

            if (facetData.manufacturerId != null)
            {
                newManufId = facetData.manufacturerId;
            }
            if (facetData.url != null)
            {
                url = Server.UrlDecode(facetData.url);
            }
            if (facetData.tabid != null)
            {
                tabid = facetData.tabid;
            }
            if (facetData.guidenew != null)
            {
                guidenew = facetData.guidenew;
            }

            isPrescription = facetData.isAvailablePrescription;
            isPolarized = facetData.isPolarized;
            isInStock = facetData.isInStock;

            if (facetData.sortby != null)
            {
                sortby = facetData.sortby;
            }

            if (facetData.gender != null)
            {
                gender = System.Web.HttpContext.Current.Server.UrlDecode(facetData.gender);
            }
            if (facetData.category != null)
            {
                category = System.Web.HttpContext.Current.Server.UrlDecode(facetData.category);
            }
            if (facetData.frameType != null)
            {
                frameType = System.Web.HttpContext.Current.Server.UrlDecode(facetData.frameType).Replace("&amp;", "&");
            }
            if (facetData.frameShape != null)
            {
                frameShape = System.Web.HttpContext.Current.Server.UrlDecode(facetData.frameShape).Replace("&amp;", "&");
            }
            if (facetData.lensColor != null)
            {
                lensColor = System.Web.HttpContext.Current.Server.UrlDecode(facetData.lensColor).Replace("&amp;", "&");
            }
            if (facetData.frameColor != null)
            {
                frameColor = System.Web.HttpContext.Current.Server.UrlDecode(facetData.frameColor).Replace("&amp;", "&");
            }
            #endregion

            GetDataFromWebCacheOrDatabase();

            HttpCookie cookie = Request.Cookies["productIds"];
            String strCookieValue = "";
            if (cookie != null)
            {
                strCookieValue = cookie.Value.ToString();
            }

            if (isPrescription == true || isPolarized == true || isInStock == true)
            {
                Filteration(isPrescription, isPolarized, isInStock);
            }

            FilterProductsByFacetData();

            #region get facet design
            if (dsfacetSearchdata != null && dsfacetSearchdata.Tables.Count > 0)
            {
                ArrayList arr_FacetData = new ArrayList();

                arr_FacetData = BindFacetData(gender, category, frameType, frameShape, lensColor, frameColor);

                for (int i = 0; i < arr_FacetData.Count; i++)
                {
                    if (arr_FacetData[i].ToString() != "")
                    {
                        switch (i)
                        {
                            case 0:
                                SbFacetGender.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0]);
                                SbFacetGendersCount.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1]);
                                break;

                            case 1:
                                SbFacetCategory.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0]);
                                SbFacetCategoryCount.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1]);
                                break;

                            case 2:
                                SbFacetFrameType.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0]);
                                SbFacetFrameTypesCount.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1]);
                                break;

                            case 3:
                                SbFacetFrameShape.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0]);
                                SbFacetFrameShapesCount.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1]);
                                break;

                            case 4:
                                SbFacetLensColor.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0]);
                                SbFacetLensColorCount.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1]);
                                break;

                            case 5:
                                SbFacetFrameColor.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[0]);
                                SbFacetFrameColorCount.Append(arr_FacetData[i].ToString().Split(new string[] { "itemCount=" }, StringSplitOptions.None)[1]);
                                break;
                        }
                    }
                }
            }
            #endregion

            Prdctcnt = 0;

            if (dsBrandProducts != null && dsBrandProducts.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
            {
                Prdctcnt = dsBrandProducts.Tables[0].Rows.Count;
                strGrid = ProductBoxlist(dsBrandProducts, Prdctcnt, 0, 12, Wishlistproduct);   /* bind filter products desing : start row = 0 , end row = 12 */
            }
            else
            {
                strGrid = "<div id=\"divgrid\"  style=\"padding-left: 15px;\">Sorry, No Result(s) Found.</div>";
            }

            #region Changed Page title, description and keywords
            DataSet ds = new DataSet();
            string pageTitle = "";
            string metaDescription = "";
            string metaKeywords = "";

            ds = CommonBLL.GetCommonDataSet("EXEC GuiGetPageTitleAndMetaTagByURL @URL='" + AppLogic.AppConfigs("LIVE_SERVER").ToString() + url.Substring(1) + "'");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                pageTitle = ds.Tables[0].Rows[0]["Page_title"].ToString();
                metaDescription = ds.Tables[0].Rows[0]["MetaDescription"].ToString();
                metaKeywords = ds.Tables[0].Rows[0]["MetaKeywords"].ToString();
            }
            #endregion

            var jsonResultall = new
            {
                strGrid = strGrid,
                SbFacetGender = SbFacetGender.ToString(),
                SbFacetGendersCount = SbFacetGendersCount.ToString(),
                SbFacetCategory = SbFacetCategory.ToString(),
                SbFacetCategoryCount = SbFacetCategoryCount.ToString(),
                SbFacetFrameType = SbFacetFrameType.ToString(),
                SbFacetFrameTypesCount = SbFacetFrameTypesCount.ToString(),
                SbFacetFrameShape = SbFacetFrameShape.ToString(),
                SbFacetFrameShapesCount = SbFacetFrameShapesCount.ToString(),
                SbFacetLensColor = SbFacetLensColor.ToString(),
                SbFacetLensColorCount = SbFacetLensColorCount.ToString(),
                SbFacetFrameColor = SbFacetFrameColor.ToString(),
                SbFacetFrameColorCount = SbFacetFrameColorCount.ToString(),
                TotalProduct = Prdctcnt.ToString(),
                pageTitle = pageTitle,
                metaDescription = metaDescription,
                metaKeywords = metaKeywords
            };

            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }

        /* Description : This method get start and end index of products and return products as per index.
         * Input  : facetData -> From this object it get start and end index of products.
         * Output : Retrun HTML design of products as a json object
         */
        public JsonResult Getpaggingdata(FacetData facetData)
        {
            #region Variable declaretion

            string url = "";
            int tabid = 0;
            int startRow = 0;
            int endRow = 0;
            string guidenew = "";
            newManufId = 0;

            //isPrescription = false;
            //isPolarized = false;
            //isInStock = true;
            //sortby = "";

            //gender = "";
            //category = "";
            //frameType = "";
            //frameShape = "";
            //lensColor = "";
            //frameColor = "";

            #endregion

            #region get filter data

            if (facetData.manufacturerId != null)
            {
                newManufId = facetData.manufacturerId;
            }
            if (facetData.url != null)
            {
                url = facetData.sortby;
            }
            if (facetData.tabid != null)
            {
                tabid = facetData.tabid;
            }
            if (facetData.startRow != null)
            {
                startRow = facetData.startRow;
            }
            if (facetData.endRow != null)
            {
                endRow = facetData.endRow;
                prdEnd = endRow;
            }
            if (facetData.guidenew != null)
            {
                guidenew = facetData.guidenew;
            }

            //isPrescription = facetData.isAvailablePrescription;
            //isPolarized = facetData.isPolarized;
            //isInStock = facetData.isInStock;
            //if (facetData.sortby != null)
            //{
            //    sortby = facetData.sortby;
            //}

            //if (facetData.gender != null)
            //{
            //    gender = System.Web.HttpContext.Current.Server.UrlDecode(facetData.gender);
            //}
            //if (facetData.category != null)
            //{
            //    category = System.Web.HttpContext.Current.Server.UrlDecode(facetData.category);
            //}
            //if (facetData.frameType != null)
            //{
            //    frameType = System.Web.HttpContext.Current.Server.UrlDecode(facetData.frameType);
            //}
            //if (facetData.frameShape != null)
            //{
            //    frameShape = System.Web.HttpContext.Current.Server.UrlDecode(facetData.frameShape);
            //}
            //if (facetData.lensColor != null)
            //{
            //    lensColor = System.Web.HttpContext.Current.Server.UrlDecode(facetData.lensColor);
            //}
            //if (facetData.frameColor != null)
            //{
            //    frameColor = System.Web.HttpContext.Current.Server.UrlDecode(facetData.frameColor);
            //}

            #endregion

            SetMoreProductsForPagging();

            //GetDataFromWebCacheOrDatabase();

            HttpCookie cookie = Request.Cookies["productIds"];
            String strCookieValue = "";
            if (cookie != null)
            {
                strCookieValue = cookie.Value.ToString();
            }

            //FilterProductsByFacetData();

            int Prdctcnt = 0;
            string strGrid = "";

            Prdctcnt = dsBrandProducts.Tables[0].Rows.Count;
            strGrid = ProductBoxlist(dsBrandProducts, Prdctcnt, startRow, endRow, Wishlistproduct);

            var jsonResultall = new
            {
                strGrid = strGrid,
                TotalProduct = Prdctcnt.ToString()
            };
            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }

        /* Description : This method get data from Webcache or from database and store it in WebCache.
         */
        private void GetDataFromWebCacheOrDatabase()
        {
            try
            {
                #region get wishlist data
                DataSet Wishlistproduct = new DataSet();
                if (Session["CustID"] != null && Session["CustID"].ToString() != "" && Session["UserName"] != null && Session["UserName"].ToString() != "")
                {
                    Wishlistproduct = CommonBLL.GetCommonDataSet("Select ProductID from tb_WishListItems Where CustomerID=" + Convert.ToInt32(Session["CustID"]) + "");
                }
                else
                {
                    Wishlistproduct = null;
                }
                #endregion

                #region facet master date
                if (WebCache.Get("wcDsfacetSearchdata" + newManufId) != null)
                {
                    dsfacetSearchdata = (DataSet)WebCache.Get("wcDsfacetSearchdata" + newManufId);
                }
                else
                {
                    dsfacetSearchdata = CommonBLL.GetCommonDataSet("EXEC GuiGetBrandFacetedMasterEG " + AppLogic.AppConfigs("StoreID") + "," + newManufId + "");
                    System.Web.Helpers.WebCache.Set("wcDsfacetSearchdata" + newManufId, dsfacetSearchdata, 720, false);
                }
                #endregion

                #region facet mapping data

                if (WebCache.Get("wcDsSearchdata" + newManufId) != null)
                {
                    dsSearchdata = (((DataSet)WebCache.Get("wcDsSearchdata" + newManufId))).Copy();
                }
                else
                {
                    dsSearchdata = CommonBLL.GetCommonDataSet("EXEC GuiGetBrandAllSearchdataEG " + newManufId + "," + AppLogic.AppConfigs("StoreID"));

                    System.Web.Helpers.WebCache.Remove("wcDsSearchdata" + newManufId);
                    System.Web.Helpers.WebCache.Set("wcDsSearchdata" + newManufId, dsSearchdata.Copy(), 720, false);
                }
                #endregion

                #region facet products
                dsBrandProducts = new DataSet();
                if (WebCache.Get("wcDsBrandProducts" + newManufId) != null)
                {
                    DataTable dt = (DataTable)JsonConvert.DeserializeObject(WebCache.Get("wcDsBrandProducts" + newManufId).ToString(), (typeof(DataTable)));
                    dsBrandProducts.Tables.Add(dt);
                }
                else
                {
                    dsBrandProducts = CommonBLL.GetCommonDataSet("EXEC GuiGetBrandProductsEG " + Convert.ToInt32(AppLogic.AppConfigs("StoreID")) + "," + newManufId + ",0,0,10000");

                    //if (dsBrandProducts != null && dsBrandProducts.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
                    //{
                    //    var UniqueRows = dsBrandProducts.Tables[0].AsEnumerable().Distinct(DataRowComparer.Default);
                    //    DataTable dt2 = UniqueRows.CopyToDataTable();
                    //    dsBrandProducts.Tables.RemoveAt(0);
                    //    dsBrandProducts.Tables.Add(dt2);
                    //}

                    if (dsBrandProducts != null && dsBrandProducts.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
                    {
                        JsonSerializerSettings objcatche = new JsonSerializerSettings();

                        System.Web.Helpers.WebCache.Remove("wcDsBrandProducts" + newManufId);
                        System.Web.Helpers.WebCache.Set("wcDsBrandProducts" + newManufId, JsonConvert.SerializeObject(dsBrandProducts.Tables[0], Formatting.None, objcatche), 720, false);
                    }
                }

                #endregion
            }
            catch (Exception ex)
            {
                CommonBLL.ErrorLog("Brand", ex.Message, ex.StackTrace);
            }
        }

        /* Description : Get filter items and make HTML string fol all filters and return as a ArrayList
         * Input  : fiter items
         * Output : HTML design string in ArrayList.
         */
        public ArrayList BindFacetData(string gender, string Category, string frameType, string frameShape, string lensColor, string frameColor)
        {
            ArrayList arrFacetData = new ArrayList();

            if (dsfacetSearchdata != null && dsfacetSearchdata.Tables.Count > 0)
            {
                for (int tblNo = 0; tblNo < dsfacetSearchdata.Tables.Count; tblNo++)
                {
                    string currFilterName = "";
                    int filterTblNo = 0;

                    switch (tblNo)
                    {
                        /* filterTblNo indicate index of Dataset 'dsfacetSearchdata' */
                        case 0: currFilterName = "Gender"; filterTblNo = tblNo + 1; break;
                        case 1: currFilterName = "Category"; filterTblNo = tblNo + 1; break;
                        case 2: currFilterName = "FrameType"; filterTblNo = tblNo + 1; break;
                        case 3: currFilterName = "FrameShape"; filterTblNo = tblNo + 1; break;
                        case 4: currFilterName = "LensColor"; filterTblNo = tblNo + 1; break;
                        case 5: currFilterName = "FrameColor"; filterTblNo = tblNo + 1; break;
                        default: currFilterName = "Empty"; break;
                    }

                    string tempFacetData = "";
                    int itemCount = 0;


                    for (int i = 0; i < dsfacetSearchdata.Tables[tblNo].Rows.Count; i++)
                    {
                        try
                        {
                            filteredPrdIds.Clear();
                            foreach (DataRow dr in dsSearchdata.Tables[filterTblNo].Select("Name like '" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "'"))
                            {
                                if (!filteredPrdIds.Contains(dr["ProductId"].ToString()))
                                    filteredPrdIds.Add(dr["ProductId"].ToString());
                            }

                            if (filteredPrdIds.Count > 0)
                            {
                                string filterName = "";
                                string imagePath = "";
                                string imageClass = "";

                                switch (tblNo)
                                {
                                    case 0: filterName = FilterProductsbySelf(gender, tblNo, i);
                                        imagePath = AppLogic.AppConfigs("FacetGenderImagePath").ToString() + dsfacetSearchdata.Tables[tblNo].Rows[i]["ImageName"].ToString();
                                        break;

                                    case 1: filterName = FilterProductsbySelf(category, tblNo, i);
                                        imagePath = AppLogic.AppConfigs("FacetCategoryImagePath").ToString() + dsfacetSearchdata.Tables[tblNo].Rows[i]["ImageName"].ToString();
                                        break;

                                    case 2: filterName = FilterProductsbySelf(frameType, tblNo, i);
                                        imagePath = AppLogic.AppConfigs("FacetFrameTypeImagePath").ToString() + dsfacetSearchdata.Tables[tblNo].Rows[i]["ImageName"].ToString();
                                        break;

                                    case 3: filterName = FilterProductsbySelf(frameShape, tblNo, i);
                                        imagePath = AppLogic.AppConfigs("FacetFrameShapeImagePath").ToString() + dsfacetSearchdata.Tables[tblNo].Rows[i]["ImageName"].ToString();
                                        break;

                                    case 4: filterName = FilterProductsbySelf(lensColor, tblNo, i);
                                        imagePath = AppLogic.AppConfigs("FacetLensColorImagePath").ToString() + dsfacetSearchdata.Tables[tblNo].Rows[i]["ImageName"].ToString();
                                        imageClass = "class=\"img-circle\"";
                                        break;

                                    case 5: filterName = FilterProductsbySelf(frameColor, tblNo, i);
                                        imagePath = AppLogic.AppConfigs("FacetFrameColorImagePath").ToString() + dsfacetSearchdata.Tables[tblNo].Rows[i]["ImageName"].ToString();
                                        imageClass = "class=\"img-circle\"";
                                        break;

                                    default:
                                        break;
                                }

                                if (tblNo != 0)
                                    FilterProducts(gender, 1);      /* 1 indicate index of Dataset 'dsSearchdata' */

                                if (tblNo != 1)
                                    FilterProducts(category, 2);    /* 2 indicate index of Dataset 'dsSearchdata' */

                                if (tblNo != 2)
                                    FilterProducts(frameType, 3);   /* 3 indicate index of Dataset 'dsSearchdata' */

                                if (tblNo != 3)
                                    FilterProducts(frameShape, 4);  /* 4 indicate index of Dataset 'dsSearchdata' */

                                if (tblNo != 4)
                                    FilterProducts(lensColor, 5);   /* 5 indicate index of Dataset 'dsSearchdata' */

                                if (tblNo != 5)
                                    FilterProducts(frameColor, 6);  /* 6 indicate index of Dataset 'dsSearchdata' */

                                int cnt = dsBrandProducts.Tables[0].Rows.Count;

                                if (filteredPrdIds.Count > 0)
                                {
                                    ++itemCount;

                                    if (tblNo == 4 || tblNo == 5)
                                    {
                                        if (!string.IsNullOrEmpty(filterName))
                                        {
                                            tempFacetData += "<li id=\"li_" + currFilterName + "_" + i.ToString() + "\" onclick=\"return checkit(this.id);\"><div class=\"active color-filter-web color-filter-item\"> <label class=\"checkbox-inline\"> <input type=\"checkbox\" id=\"chk_" + currFilterName + "_" + i.ToString() + "\"  style=\"display:none\" checked=\"checked\"><span class=\"color-filter\"><img " + imageClass + " src=\"" + imagePath + "\" alt=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\" title=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\"></span></label> <p><span>" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "</span> (" + filteredPrdIds.Count + ")</p></div></li>";
                                        }
                                        else
                                        {
                                            tempFacetData += "<li id=\"li_" + currFilterName + "_" + i.ToString() + "\" onclick=\"return checkit(this.id);\"><div class=\"color-filter-web color-filter-item\"> <label class=\"checkbox-inline\"> <input type=\"checkbox\" id=\"chk_" + currFilterName + "_" + i.ToString() + "\"  style=\"display:none\"><span class=\"color-filter\"> <img " + imageClass + " src=\"" + imagePath + "\" alt=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\" title=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\"></span></label> <p><span>" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "</span> (" + filteredPrdIds.Count + ")</p></div></li>";
                                        }
                                    }
                                    else
                                    {

                                        if (!string.IsNullOrEmpty(filterName))
                                        {
                                            tempFacetData += "<li id=\"li_" + currFilterName + "_" + i.ToString() + "\" onclick=\"return checkit(this.id);\"><div class=\"active color-filter-web color-filter-item\"> <label class=\"checkbox-inline\"> <input type=\"checkbox\" id=\"chk_" + currFilterName + "_" + i.ToString() + "\"  style=\"display:none\" checked=\"checked\"> <img " + imageClass + " src=\"" + imagePath + "\" alt=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\" title=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\"></label> <p><span>" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "</span> (" + filteredPrdIds.Count + ")</p></div></li>";
                                        }
                                        else
                                        {
                                            tempFacetData += "<li id=\"li_" + currFilterName + "_" + i.ToString() + "\" onclick=\"return checkit(this.id);\"><div class=\"color-filter-web color-filter-item\"> <label class=\"checkbox-inline\"> <input type=\"checkbox\" id=\"chk_" + currFilterName + "_" + i.ToString() + "\"  style=\"display:none\"> <img " + imageClass + " src=\"" + imagePath + "\" alt=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\" title=\"" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "\"></label> <p><span>" + dsfacetSearchdata.Tables[tblNo].Rows[i]["Name"].ToString() + "</span> (" + filteredPrdIds.Count + ")</p></div></li>";
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                        }
                    }

                    if (itemCount > 0)
                    {
                        arrFacetData.Add(tempFacetData + "itemCount=" + itemCount);
                    }
                    else
                    {
                        arrFacetData.Add("");
                    }
                }


            }

            return arrFacetData;
        }

        /* Description : this method get one filter items and check it is checked or not.
         * Input  : filterNames -> Get one filter items
         *          tableNo     -> It is a table index of current filter in master data set.
         *          rowNo       -> It is a row now number of current filter table.
         * Output : return filter name if it is selected else return blanck.
         */
        public string FilterProductsbySelf(string filterNames, int tableNo, int rowNo)
        {
            string filterName = "";
            if (filterNames != "")
            {
                string[] arr_FilterNames = filterNames.Split("~".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

                foreach (string str in arr_FilterNames)
                {
                    if (str.Trim().ToLower() == dsfacetSearchdata.Tables[tableNo].Rows[rowNo]["Name"].ToString().Trim().ToLower())
                    {
                        filterName = dsfacetSearchdata.Tables[tableNo].Rows[rowNo]["Name"].ToString().Trim().ToLower();
                    }
                }
            }
            return filterName;
        }

        /* Description : It take selected items of one filter and filter productId's from old filter productid list and update it.
         * Input  : str -> String of selected items of one filter 
         *          tblNo -> index of mapping data set which is dsSearchdata
         */
        public void FilterProducts(string str, int tblNo)
        {
            try
            {
                List<string> newFilteredPrdIds = new List<string>();
                if (str != "")
                {
                    string[] arr_FilterNames = str.Split("~".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

                    for (int k = 0; k < filteredPrdIds.Count; k++)
                    {
                        foreach (DataRow drFilterName in dsSearchdata.Tables[tblNo].Select("ProductId=" + filteredPrdIds[k].ToString() + ""))
                        {
                            foreach (string strFilterName in arr_FilterNames)
                            {
                                if (drFilterName["name"].ToString().Trim().ToLower() == strFilterName.Trim().ToLower() && drFilterName["ProductId"].ToString() == filteredPrdIds[k].ToString())
                                {
                                    if (!newFilteredPrdIds.Contains(drFilterName["ProductId"].ToString()))
                                        newFilteredPrdIds.Add(drFilterName["ProductId"].ToString());
                                }
                            }
                        }
                    }
                    filteredPrdIds.Clear();
                    filteredPrdIds = newFilteredPrdIds;
                }
            }
            catch (Exception ex)
            {
            }
        }

        /* Description : Filter products from current products DataSet by filter items
         */
        public void FilterProductsByFacetData()
        {
            string Pidsmulti = ",";

            if (dsBrandProducts != null && (gender != "" || category != "" || frameType != "" || frameShape != "" || lensColor != "" || frameColor != ""))
            {
                for (int icount = 0; icount < dsBrandProducts.Tables[0].Rows.Count; icount++)
                {
                    if (Pidsmulti.IndexOf("," + dsBrandProducts.Tables[0].Rows[icount]["ProductId"].ToString() + ",") > -1)
                    {
                        dsBrandProducts.Tables[0].Rows.RemoveAt(icount);
                        dsBrandProducts.Tables[0].AcceptChanges();
                        icount--;
                        continue;
                    }
                    else
                    {
                        Pidsmulti += dsBrandProducts.Tables[0].Rows[icount]["ProductId"].ToString() + ",";

                        bool g = true; bool c = true; bool ft = true; bool fs = true; bool lc = true; bool fc = true;

                        if (dsSearchdata != null && dsSearchdata.Tables.Count > 0)
                        {
                            if (gender != "")                                                       // Here 0 is index of table in dsBrandProducts  // icount is index of row in dsBrandProducts
                                g = IsProductInCategoryFilter_Common(gender, 1, 0, icount);         // here 1 is a index of table in dsSearchdata

                            if (category != "")
                                c = IsProductInCategoryFilter_Common(category, 2, 0, icount);       // here 2 is a index of table in dsSearchdata

                            if (frameType != "")
                                ft = IsProductInCategoryFilter_Common(frameType, 3, 0, icount);     // here 3 is a index of table in dsSearchdata

                            if (frameShape != "")
                                fs = IsProductInCategoryFilter_Common(frameShape, 4, 0, icount);    // here 4 is a index of table in dsSearchdata

                            if (lensColor != "")
                                lc = IsProductInCategoryFilter_Common(lensColor, 5, 0, icount);     // here 5 is a index of table in dsSearchdata

                            if (frameColor != "")
                                fc = IsProductInCategoryFilter_Common(frameColor, 6, 0, icount);    // here 6 is a index of table in dsSearchdata

                            if (g == true && c == true && ft == true && fs == true && lc == true && fc == true)
                            {
                            }
                            else
                            {
                                dsBrandProducts.Tables[0].Rows.RemoveAt(icount);
                                icount--;
                            }
                        }
                    }
                }
            }

            ShortingProducts();
        }

        /* Description : this method check that current row product is in selected filter items or not.
         * Input  : str -> It is a sting of filter items.
         *          priTable -> It is a index of table in mapping dataset as per str(filter)
         * Output : It boolean value as per product is avaible or not in current filter data.
         */
        public bool IsProductInCategoryFilter_Common(string str, int priTable, int secTable, int icount)
        {
            try
            {
                bool b = false;
              
                if (dsSearchdata.Tables.Count > priTable)
                {
                    string[] sh = str.Replace("~", ",").Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
                    foreach (DataRow drh in dsSearchdata.Tables[priTable].Select("ProductId=" + dsBrandProducts.Tables[secTable].Rows[icount]["ProductId"].ToString() + ""))
                    {
                        foreach (string sllast in sh)
                        {
                            if (drh["name"].ToString().ToLower() == sllast.ToLower().Trim() && dsBrandProducts.Tables[secTable].Rows[icount]["ProductId"].ToString() == drh["ProductId"].ToString())
                            {
                                b = true;
                                break;
                            }
                        }
                        if (b == true)
                        {
                            break;
                        }
                    }
                }

                return b;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        /* Description : It can filter products data and it's mapping data as per prescription, polarized, and instock
         * Input  : prescription, polarized, and instock
         */
        public void Filteration(bool prescription, bool polarized, bool instock)
        {
            try
            {
                #region facet products

                dsBrandProducts = new DataSet();
                DataTable dtprds = (DataTable)JsonConvert.DeserializeObject(WebCache.Get("wcDsBrandProducts" + newManufId).ToString(), (typeof(DataTable)));
                dsBrandProducts.Tables.Add(dtprds);

                System.Type PrdInvType = dsBrandProducts.Tables[0].Rows[0][5].GetType();
                string typePrdInv = PrdInvType.ToString();

                System.Type PrdIdType = dsBrandProducts.Tables[0].Rows[0][4].GetType();
                string typePrdId = PrdIdType.ToString();

                #endregion

                #region facet mapping data

                dsSearchdata = new DataSet();
                if (WebCache.Get("wcDsSearchdata" + newManufId) != null)
                {
                    dsSearchdata = ((DataSet)WebCache.Get("wcDsSearchdata" + newManufId)).Copy();
                }

                #endregion

                if (dsBrandProducts != null && dsBrandProducts.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
                {
                    #region filter prescription products
                    if (prescription == true)
                    {
                        try
                        {
                            var PrescriptionPrds = from tbl in dsBrandProducts.Tables[0].AsEnumerable() where tbl.Field<bool>("RxAble") == true select tbl;

                            if (PrescriptionPrds.Count() > 0)
                            {
                                DataTable dt = new DataTable();
                                dt = PrescriptionPrds.CopyToDataTable();
                                dsBrandProducts.Tables[0].Clear();
                                dsBrandProducts.Tables[0].Merge(dt, true);
                            }
                            else
                            {
                                dsBrandProducts.Tables[0].Clear();
                            }
                        }
                        catch (Exception ex)
                        { }
                    }
                    #endregion

                    #region filter Polarized products
                    if (polarized == true)
                    {
                        try
                        {
                            var PolarizedPrds = from tbl in dsBrandProducts.Tables[0].AsEnumerable() where tbl.Field<bool>("Polarized") == true select tbl;
                            if (PolarizedPrds.Count() > 0)
                            {
                                DataTable dt = new DataTable();
                                dt = PolarizedPrds.CopyToDataTable();
                                dsBrandProducts.Tables[0].Clear();
                                dsBrandProducts.Tables[0].Merge(dt, true);
                            }
                            else
                            {
                                dsBrandProducts.Tables[0].Clear();
                            }
                        }
                        catch (Exception ex)
                        { }
                    }
                    #endregion

                    #region filter instock products
                    if (instock == true)
                    {
                        try
                        {
                            var InstockPrds = new DataTable();
                            if (typePrdInv.Contains("32"))
                            {
                                InstockPrds = (from tbl in dsBrandProducts.Tables[0].AsEnumerable() where tbl.Field<Int32>("Inventory") > 0 select tbl).CopyToDataTable();
                            }
                            else if (typePrdInv.Contains("64"))
                            {
                                InstockPrds = (from tbl in dsBrandProducts.Tables[0].AsEnumerable() where tbl.Field<long>("Inventory") > 0 select tbl).CopyToDataTable();
                            }

                            if (InstockPrds != null && InstockPrds.Rows.Count > 0)
                            {
                                DataTable dt = new DataTable();
                                dt = InstockPrds;
                                dsBrandProducts.Tables[0].Clear();
                                dsBrandProducts.Tables[0].Merge(dt, true);
                            }
                            else
                            {
                                dsBrandProducts.Tables[0].Clear();
                            }

                            //var InstockPrds = from tbl in dsBrandProducts.Tables[0].AsEnumerable() where tbl.Field<Int32>("Inventory") > 0 select tbl;
                            //if (InstockPrds.Count() > 0)
                            //{
                            //    DataTable dt = new DataTable();
                            //    dt = InstockPrds.CopyToDataTable();
                            //    dsBrandProducts.Tables[0].Clear();
                            //    dsBrandProducts.Tables[0].Merge(dt, true);
                            //}
                            //else
                            //{
                            //    dsBrandProducts.Tables[0].Clear();
                            //}
                        }
                        catch (Exception ex)
                        { }
                    }
                    #endregion

                    #region filter mapping data as per filter products

                    if (dsSearchdata != null && dsSearchdata.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 1; i < dsSearchdata.Tables.Count; i++)
                        {
                            try
                            {
                                var mapping = new DataTable();
                                if (typePrdId.Contains("32"))
                                {
                                    mapping = (from tbl1 in dsSearchdata.Tables[i].AsEnumerable() join tbl2 in dsBrandProducts.Tables[0].AsEnumerable() on tbl1.Field<Int32>("ProductID") equals tbl2.Field<Int32>("ProductID") select tbl1).CopyToDataTable();
                                }
                                else if (typePrdId.Contains("64"))
                                {
                                    mapping = (from tbl1 in dsSearchdata.Tables[i].AsEnumerable() join tbl2 in dsBrandProducts.Tables[0].AsEnumerable() on tbl1.Field<Int32>("ProductID") equals tbl2.Field<long>("ProductID") select tbl1).CopyToDataTable();
                                }

                                if (mapping.Rows.Count > 0)
                                {
                                    DataTable dt = new DataTable();
                                    dt = mapping;
                                    dsSearchdata.Tables[i].Clear();
                                    dsSearchdata.Tables[i].Merge(dt, false);
                                }
                                else
                                {
                                    dsSearchdata.Tables[i].Clear();
                                }

                                //var mapping = (from tbl1 in dsSearchdata.Tables[i].AsEnumerable() join tbl2 in dsBrandProducts.Tables[0].AsEnumerable() on tbl1.Field<Int32>("ProductID") equals tbl2.Field<Int32>("ProductID") select tbl1);

                                //if (mapping.Count() > 0)
                                //{
                                //    DataTable dtMapdata = new DataTable();
                                //    dtMapdata = mapping.CopyToDataTable();
                                //    dsSearchdata.Tables[i].Rows.Clear();
                                //    dsSearchdata.Tables[i].Merge(dtMapdata, true);
                                //}
                                //else
                                //{
                                //    dsSearchdata.Tables[i].Rows.Clear();
                                //}
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                    }
                    else
                    {
                        ClearMappingData();
                    }
                    #endregion
                }
                else
                {
                    ClearMappingData();
                }
            }
            catch (Exception ex)
            { }
        }

        /* Description : This method is only use for sorting products and rebind grid view. This method will is call from View.
         * Input  : Sortby -> It is a sorting variable which contains 'a-z','z-a', and so on.
         *          manufactureId -> BrandId
         * Output : 
         */
        public JsonResult ShortingProductsAndBinding(string Sortby, string manufactureId)
        {
            newManufId = Convert.ToInt32(manufactureId);
            sortby = Sortby;
            string productsDesign = "";

            if (System.Web.Helpers.WebCache.Get("wcDsBrandProductsFiltered" + newManufId) != null)
                dsBrandProducts = System.Web.Helpers.WebCache.Get("wcDsBrandProductsFiltered" + newManufId);
            else
                dsBrandProducts = CommonBLL.GetCommonDataSet("EXEC GuiGetBrandProductsEG " + Convert.ToInt32(AppLogic.AppConfigs("StoreID")) + "," + newManufId + ",0,0,10000");

            ShortingProducts();

            productsDesign = ProductBoxlist(dsBrandProducts, dsBrandProducts.Tables[0].Rows.Count, 0, prdEnd, Wishlistproduct);

            var jsonResult = Json(productsDesign, JsonRequestBehavior.AllowGet);
            return jsonResult;
        }

        /* Description : Sorting products as per sortby value and generare new view and then refill on products WebCache.
         */
        public void ShortingProducts()
        {
            if (dsBrandProducts.Tables.Count > 0)
            {
                DataView dv = dsBrandProducts.Tables[0].DefaultView;
                if (sortby.ToLower() == "a-z")
                {
                    dv.Sort = "ModelName ASC";
                }
                else if (sortby.ToLower() == "z-a")
                {
                    dv.Sort = "ModelName DESC";
                }
                else if (sortby.ToLower() == "low-high")
                {
                    dv.Sort = "Price ASC";
                }
                else if (sortby.ToLower() == "high-low")
                {
                    dv.Sort = "Price DESC";
                }
                else if (sortby.ToLower() == "bestseller")
                {
                    dv.Sort = "BestSeller DESC";
                }
                else
                {
                    dv.Sort = "DisplayOrder ASC";
                }
                dsBrandProducts.Tables.RemoveAt(0);
                dsBrandProducts.Tables.Add(dv.ToTable());

                JsonSerializerSettings objcatche = new JsonSerializerSettings();
                System.Web.Helpers.WebCache.Set("wcDsBrandProductsFiltered" + newManufId + "", dsBrandProducts, 720, false);
            }
        }

        /* Description : This method is used to get last filtered data from it's WebCache or from products WebCache or from database for only fast paggination.        
         */
        public void SetMoreProductsForPagging()
        {
            if (WebCache.Get("wcDsBrandProductsFiltered" + newManufId) != null)
            {
                dsBrandProducts = System.Web.Helpers.WebCache.Get("wcDsBrandProductsFiltered" + newManufId);
            }
            else if (WebCache.Get("wcDsBrandProducts" + newManufId) != null)
            {
                dsBrandProducts = new DataSet();
                DataTable dt = (DataTable)JsonConvert.DeserializeObject(WebCache.Get("wcDsBrandProducts" + newManufId + "").ToString(), (typeof(DataTable)));
                dsBrandProducts.Tables.Add(dt);
            }
            else
            {
                dsBrandProducts = CommonBLL.GetCommonDataSet("EXEC GuiGetBrandProductsEG " + Convert.ToInt32(AppLogic.AppConfigs("StoreID")) + "," + newManufId + ",0,0,10000");
            }
        }

        /* Description : Clear all mapping data from dataset, this method is called when product dataset is empty.
         */
        public void ClearMappingData()
        {
            #region clear all data from mapping tables
            for (int i = 0; i < dsSearchdata.Tables.Count; i++)
            {
                dsSearchdata.Tables[i].Clear();
            }
            #endregion
        }

        /* Description : This method get product dataset, start index, end index and wishlist products and return string of products.
         * Input  : dsBrandProducts -> Dataset od products
         *          Prdctcnt -> Total products available in dataset
         *          prdStart -> start index of row in proruct dataset
         *          prdEnd -> end index of row in proruct dataset
         *          Wishlistproduct -> it contains wishlist products
         * Output : HTML string of proudcts          
         */
        private string ProductBoxlist(DataSet dsBrandProducts, int Prdctcnt, int prdStart, int prdEnd, DataSet Wishlistproduct)
        {
            string strGrid = "";

            // for SEO detail
            int SeoHeaderTag = 2;

            string strMainImageName = "";
            if (dsBrandProducts != null && dsBrandProducts.Tables.Count > 0 && dsBrandProducts.Tables[0].Rows.Count > 0)
            {
                for (int i = prdStart; i < dsBrandProducts.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        if (i >= prdEnd)
                        {
                            break;
                        }

                        strGrid += "<div class=\"col-md-4 col-sm-6 col-xs-12 list-item box\">";
                        strGrid += "<article class=\"most-wanted-pro-box\">";
                        strGrid += "<figure>";
                        strGrid += "<div class=\"most-wanted-pro-img\">";
                        if (dsBrandProducts.Tables[0].Rows[i]["ImageName"] != null)
                        {
                            strMainImageName = GetIconImageProduct(dsBrandProducts.Tables[0].Rows[i]["ImageName"].ToString()).Data.ToString();
                            strGrid += "<a href=\"/" + dsBrandProducts.Tables[0].Rows[i]["sename"].ToString().ToLower() + ".html\" title=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandProducts.Tables[0].Rows[i]["name"].ToString()) + "\"> <span class=\"pro-img-span\"><img id=\"img_" + dsBrandProducts.Tables[0].Rows[i]["ProductId"].ToString() + "\" src=\"" + strMainImageName + "\" alt=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandProducts.Tables[0].Rows[i]["name"].ToString()) + "\" title=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandProducts.Tables[0].Rows[i]["name"].ToString()) + "\" /></span></a>";
                        }

                        if (dsBrandProducts.Tables[0].Rows[i]["Newarrival"].ToString().ToLower() == "true")
                        {
                            strGrid += "<span class=\"new-tag pro-tag\">New</span>";
                        }

                        if (dsBrandProducts.Tables[0].Rows[i]["Polarized"].ToString().ToLower() == "true")
                        {
                            strGrid += "<span class=\"polorized-tag pro-tag black-tooltip\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Polarization\"><i class=\"polarization-icon\"><img alt=\"Polarization\" title=\"Polarization\" src=\"/images/polarized.png\" width=\"30px\"></i></span>";
                        }

                        if (dsBrandProducts.Tables[0].Rows[i]["BestSeller"].ToString().ToLower() == "true")
                        {
                            strGrid += "<span class=\"bestseller-tag pro-tag\">Best Seller</span>";
                        }

                        strGrid += "</div>";
                        strGrid += "<figcaption class=\"most-wanted-pro-details\">";
                        strGrid += "<div class=\"most-wanted-pro-name manufacturer\">";

                        // for SEO detail

                        strGrid += "<div class=\"most-wanted-pro-name-h2\"><a href=\"/" + dsBrandProducts.Tables[0].Rows[i]["sename"].ToString().ToLower() + ".html\" title=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandProducts.Tables[0].Rows[i]["ModelName"].ToString()) + "\"><strong><img src=\"" + GetMenuIconImageBrand(dsBrandProducts.Tables[0].Rows[i]["Manufacturelogo"].ToString()) + "\" title=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandProducts.Tables[0].Rows[i]["ManufactureName"].ToString()) + "\"  alt=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandProducts.Tables[0].Rows[i]["ManufactureName"].ToString()) + "\" class=\"prod-brand-img\"></strong> <span class=\"most-wanted-name\">";
                        if (SeoHeaderTag < 7)
                        {
                            strGrid += "<h" + SeoHeaderTag + " >" + dsBrandProducts.Tables[0].Rows[i]["ModelName"].ToString() + "</h" + SeoHeaderTag + ">";
                            SeoHeaderTag++;
                        }
                        else
                        {
                            SeoHeaderTag = 2;
                            strGrid += "<h" + SeoHeaderTag + " >" + dsBrandProducts.Tables[0].Rows[i]["ModelName"].ToString() + "</h" + SeoHeaderTag + ">";
                        }
                        strGrid += "</span></a></div>";

                        strGrid += "</div>";

                        string strColors = "";
                        int moreColor = Convert.ToInt32(dsBrandProducts.Tables[0].Rows[i]["MoreColorCount"].ToString());
                        if (moreColor == 1)
                        {
                            strColors = " | <strong>" + moreColor + " Color</strong>";
                        }
                        else if (moreColor > 1)
                        {
                            strColors = " | <strong>" + moreColor + " Colors</strong>";
                        }

                        strGrid += CalculatePrice(dsBrandProducts, i).Replace("###colors###", strColors);

                        strGrid += "<div class=\"col-sm-12 col-xs-12 p-b-10\"><a href=\"/" + dsBrandProducts.Tables[0].Rows[i]["sename"].ToString().ToLower() + ".html\" class=\"btn btn-custom btn-sm\">Buy Now <i class=\"fa fa-caret-right\" aria-hidden=\"true\"></i></a></div>";

                        if (Wishlistproduct != null && Wishlistproduct.Tables.Count > 0 && Wishlistproduct.Tables[0].Rows.Count > 0)
                        {
                            var result = Wishlistproduct.Tables[0].Select("ProductId=" + dsBrandProducts.Tables[0].Rows[i]["ProductId"].ToString() + "");

                            if (result != null && result.Count() > 0)
                                strGrid += "<div class=\"wishlish-icon\"><a  id=\"wish_" + dsBrandProducts.Tables[0].Rows[i]["ProductId"].ToString() + "\" class=\"pro-list-wishlist active\" href=\"javascript:void(0)\" onclick=\"Removefromwishlist(" + dsBrandProducts.Tables[0].Rows[i]["ProductID"].ToString() + ");\" ><i class=\"fa fa-heart\"></i></a></div>";
                            else
                                strGrid += "<div class=\"wishlish-icon\"><a  id=\"wish_" + dsBrandProducts.Tables[0].Rows[i]["ProductId"].ToString() + "\" class=\"pro-list-wishlist\" href=\"javascript:void(0)\" onclick=\"Addtowishlist(" + dsBrandProducts.Tables[0].Rows[i]["ProductID"].ToString() + ");\" ><i class=\"fa fa-heart-o\"></i></a></div>";
                        }
                        else
                        {
                            strGrid += "<div class=\"wishlish-icon\"><a  id=\"wish_" + dsBrandProducts.Tables[0].Rows[i]["ProductId"].ToString() + "\" class=\"pro-list-wishlist\" href=\"javascript:void(0)\" onclick=\"Addtowishlist(" + dsBrandProducts.Tables[0].Rows[i]["ProductID"].ToString() + ");\" ><i class=\"fa fa-heart-o\"></i></a></div>";
                        }
                        strGrid += "<div class=\"pro-review-box\">" + Getrating(Convert.ToDecimal(dsBrandProducts.Tables[0].Rows[i]["avgrating"])) + " (" + Convert.ToInt32(dsBrandProducts.Tables[0].Rows[i]["reviewtotlacount"]) + " Reviews)</div>";

                        strGrid += "</figcaption>";
                        strGrid += "</figure>";
                        strGrid += "</article>";
                        strGrid += "</div>";
                    }
                    catch (Exception ex)
                    { }
                }
                if (Prdctcnt > prdEnd)
                {
                    strGrid += "<div class=\"col-lg-12 form-group text-center load_more_main col-xs-12\" id=\"loadMoreData\"><a href=\"javascript:void(0)\" onclick=\"loadMoreData()\" class=\"btn btn-custom-1 btn-lg load_more_add\" id=\"load_more_add\"><img src=\"/images/load-more-arrow.gif\" class=\"loadmore-img\" alt=\"Loading...\" title=\"Loading...\">Load More<img src=\"/images/load-more-arrow.gif\" class=\"loadmore-img\" alt=\"Loading...\" title=\"Loading...\"></a></div>";
                }
            }
            else
            {
                strGrid = "<div id=\"divgrid\"  style=\"padding-left: 15px;\">Sorry, No Result(s) Found.</div>";

            }
            return strGrid;
        }

        #endregion

        public JsonResult GetIconImageProduct(String img)
        {
            String imagepath = String.Empty;
            imagepath = AppLogic.AppConfigs("ImagePathProduct") + "medium/" + img;

            if (System.IO.File.Exists(Server.MapPath(imagepath)))
            {

            }
            else
            {
                imagepath = "";
            }
            var jsonResultall = Json(imagepath, JsonRequestBehavior.AllowGet);
            return jsonResultall;

        }
        public JsonResult GetIconBrand(String img)
        {
            String imagepath = String.Empty;
            imagepath = AppLogic.AppConfigs("ImagePathProduct") + "medium/" + img;

            if (System.IO.File.Exists(Server.MapPath(imagepath)))
            {

            }
            else
            {
                imagepath = "";
            }
            var jsonResultall = Json(imagepath, JsonRequestBehavior.AllowGet);
            return jsonResultall;

        }
        private void BindBrandDetails(Int32 manufacturerId)
        {
            DataSet dsBrandDetail = new DataSet();
            dsBrandDetail = CommonBLL.GetCommonDataSet("SELECT ManufactureID,Name,BannerTitle,SEName,SETitle,SEKeywords,SEDescription,Description,BannerImage FROM tb_Manufacture WHERE ISNULL(Deleted,0) = 0 AND ISNULL(Active,0)=1 AND  ISNULL(StoreID,0) = " + AppLogic.AppConfigs("StoreId").ToString() + " AND ISNULL(ManufactureID,0) = " + manufacturerId);
            //ViewBag.Title = "";

            string brandBanner = "";
            string breadCrumb = "<div class=\"col-sm-12 col-xs-12 breadcrumbs p-0\" itemscope=\"\" itemtype=\"/Breadcrumb\"> <a href=\"index.html\" title=\"Eyeglass123\">Home</a> ";

            if (dsBrandDetail != null && dsBrandDetail.Tables.Count > 0 && dsBrandDetail.Tables[0].Rows.Count > 0)
            {
                //ViewBag.Title = dsBrand.Tables[0].Rows[0]["Name"].ToString();

                /* bind breadcrum */
                breadCrumb += "<meta itemprop=\"url\" content=\"" + dsBrandDetail.Tables[0].Rows[0]["Name"].ToString() + "\"><span class=\"title\" itemprop=\"title\">" + dsBrandDetail.Tables[0].Rows[0]["Name"].ToString() + "</span></div>";

                if (dsBrandDetail.Tables[0].Rows[0]["Name"] != null && !String.IsNullOrEmpty(dsBrandDetail.Tables[0].Rows[0]["Name"].ToString()))
                {
                    ViewBag.Metatitle = dsBrandDetail.Tables[0].Rows[0]["SETitle"];
                }

                /* bind Brand Meta Discription & Meta Keywords */
                if (!string.IsNullOrEmpty(dsBrandDetail.Tables[0].Rows[0]["SEKeywords"].ToString()))
                {
                    ViewBag.MetaKeywords = dsBrandDetail.Tables[0].Rows[0]["SEKeywords"].ToString();
                }
                else
                {
                    ViewBag.MetaKeywords = AppLogic.AppConfigs("SiteSEKeywords").ToString();
                }

                if (!string.IsNullOrEmpty(dsBrandDetail.Tables[0].Rows[0]["SEDescription"].ToString()))
                {
                    ViewBag.MetaDescription = dsBrandDetail.Tables[0].Rows[0]["SEDescription"].ToString();
                }
                else
                {
                    ViewBag.MetaDescription = AppLogic.AppConfigs("SiteSEDescription").ToString();
                }

                /* bind Brand description*/
                if (dsBrandDetail.Tables[0].Rows[0]["Description"] != null && !String.IsNullOrEmpty(dsBrandDetail.Tables[0].Rows[0]["Description"].ToString()))
                {
                    ViewBag.BrandDescription = "<div class=\"sub-page-title custome-title\"><h1 id=\"BrandName\">" + dsBrandDetail.Tables[0].Rows[0]["BannerTitle"].ToString() + "</h1></div><div class=\"sub-page-text custome-text\"> " + dsBrandDetail.Tables[0].Rows[0]["Description"].ToString() + " </div>";
                }


                //google script
                // Below commented script added at _Layout.cshtml
                //strgooglegtag = "<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-62873332-1\"></script>\n";
                //strgooglegtag += "<script>\n";
                //strgooglegtag += "window.dataLayer = window.dataLayer || [];\n";
                //strgooglegtag += "function gtag(){dataLayer.push(arguments);}\n";
                //strgooglegtag += "gtag('js', new Date());\n";
                //strgooglegtag += "gtag('config', 'UA-62873332-1');\n";
                //strgooglegtag += "gtag('config', 'AW-980219640');\n";
                //strgooglegtag += "</script>\n";
                strgooglegtag += "<script>\n";
                strgooglegtag += "gtag('event', 'page_view', {\n";
                strgooglegtag += " 'send_to': 'AW-980219640',\n";
                strgooglegtag += "'ecomm_pagetype': 'category',\n";
                strgooglegtag += "'ecomm_category': '" + dsBrandDetail.Tables[0].Rows[0]["Name"].ToString().Replace("'", "''") + "'\n";
                strgooglegtag += " });\n";
                strgooglegtag += "</script>";

                ViewBag.BrandSEOScript = strgooglegtag.ToString();
                //end here

                /* bind Brand Banner */
                string bannerImage = "";
                bannerImage = AppLogic.AppConfigs("BrandBannerPath") + dsBrandDetail.Tables[0].Rows[0]["BannerImage"].ToString();
                if (!string.IsNullOrEmpty(bannerImage) && System.IO.File.Exists(Server.MapPath(bannerImage)))
                {
                    brandBanner += "<img style=\"display: block; \" title=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandDetail.Tables[0].Rows[0]["Name"].ToString()) + "\" alt=\"" + System.Web.HttpContext.Current.Server.HtmlEncode(dsBrandDetail.Tables[0].Rows[0]["Name"].ToString()) + "\" src=\"" + bannerImage + "\">";
                }
                else
                {
                    brandBanner += "<img src=\"/images/featured-banner-bg.jpg\" title=\"" + dsBrandDetail.Tables[0].Rows[0]["Name"].ToString() + "\" alt=\"" + dsBrandDetail.Tables[0].Rows[0]["Name"].ToString() + "\" style=\"display: block; \">";
                }
            }
            else
            {
                breadCrumb += "</div>";
            }
            var storeId = AppLogic.AppConfigs("storeid");

            //ViewBag.Metatitle = AppLogic.AppConfigs("SiteSETitle").ToString();
            //ViewBag.MetaDescription = AppLogic.AppConfigs("SiteSEDescription").ToString();
            //ViewBag.MetaKeywords = AppLogic.AppConfigs("SiteSEKeywords").ToString();
            ViewBag.BrandBanner = brandBanner;
            ViewBag.BreadCrumb = breadCrumb;
        }

        public JsonResult CategoryAllDetails(string catid, string catname)
        {
            string strcategory = "";
            string strQuery = @"WITH Emp_CTE AS (

SELECT tb_CategoryMapping.CategoryID,tb_CategoryMapping.ParentCategoryID,tb_Category.Name,tb_Category.Sename,tb_Category.SEKeywords,tb_Category.SEDescription FROM tb_Category INNER JOIN tb_CategoryMapping on tb_Category.CategoryID=tb_CategoryMapping.CategoryID WHERE  tb_CategoryMapping.CategoryID=" + catid + @" and StoreID=" + AppLogic.AppConfigs("StoreId").ToString() + @" and isnull(active,0)=1 and isnull(deleted,0)=0  
UNION ALL
  SELECT tb_CategoryMapping.CategoryID,tb_CategoryMapping.ParentCategoryID,tb_Category.Name,tb_Category.Sename,tb_Category.SEKeywords,tb_Category.SEDescription FROM tb_Category INNER JOIN tb_CategoryMapping on tb_Category.CategoryID=tb_CategoryMapping.CategoryID INNER JOIN Emp_CTE on Emp_CTE.ParentCategoryID=tb_CategoryMapping.CategoryID WHERE   StoreID=" + AppLogic.AppConfigs("StoreId").ToString() + @" and isnull(active,0)=1 and isnull(deleted,0)=0 
--FROM HumanResources.Employee e
--INNER JOIN Emp_CTE ecte ON ecte.EmployeeID = e.ManagerID
)
SELECT DISTINCT Emp_CTE.CategoryID,Emp_CTE.ParentCategoryID,Emp_CTE.name,Emp_CTE.Sename,Emp_CTE.SEKeywords,Emp_CTE.SEDescription
FROM Emp_CTE  INNER JOIN tb_CategoryMapping on Emp_CTE.CategoryID=tb_CategoryMapping.ParentCategoryID";
            DataSet dsallcategory = new DataSet();
            dsallcategory = CommonBLL.GetCommonDataSet(strQuery);
            DataSet dsBrandProductsall = new DataSet();
            strcategory = "<ul class=\"categorymaindrop\">";
            bool getcategory = false;
            if (dsallcategory != null && dsallcategory.Tables.Count > 0 && dsallcategory.Tables[0].Rows.Count > 0)
            {

                for (int i = 0; i < dsallcategory.Tables[0].Rows.Count; i++)
                {
                    if (dsallcategory.Tables[0].Rows[i]["CategoryID"].ToString() != catid)
                    {
                        getcategory = true;
                        dsBrandProductsall = CommonBLL.GetCommonDataSet("SELECT  Distinct Count(Distinct tb_ProductCategory.ProductID) FROM tb_Product INNER JOIN tb_ProductCategory on tb_Product.ProductID=tb_ProductCategory.ProductID WHERE StoreId= " + AppLogic.AppConfigs("StoreId").ToString() + " and isnull(Active,0)=1 and isnull(Deleted,0)=0 and CategoryID in (SELECT DISTINCT items FROM dbo.GetParentcatgory(cast(" + dsallcategory.Tables[0].Rows[i]["CategoryID"].ToString() + " AS VARCHAR(50)),5))");
                        if (dsBrandProductsall != null && dsBrandProductsall.Tables.Count > 0 && dsBrandProductsall.Tables[0].Rows.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(dsBrandProductsall.Tables[0].Rows[0][0].ToString()) && Convert.ToInt32(dsBrandProductsall.Tables[0].Rows[0][0].ToString()) > 0)
                            {
                                strcategory += "<li class=\"categorydropdown\"  onclick=\"showallcategory(this);\"><a href=\"/" + dsallcategory.Tables[0].Rows[i]["sename"].ToString() + ".html\">" + dsallcategory.Tables[0].Rows[i]["name"].ToString().Trim() + "(" + dsBrandProductsall.Tables[0].Rows[0][0].ToString() + ")</a></li>";
                            }
                            else
                            {
                            }
                        }
                        else
                        {
                        }
                    }
                }
            }
            dsBrandProductsall = CommonBLL.GetCommonDataSet("SELECT  Distinct Count(Distinct tb_ProductCategory.ProductID) FROM tb_Product INNER JOIN tb_ProductCategory on tb_Product.ProductID=tb_ProductCategory.ProductID WHERE StoreId=" + AppLogic.AppConfigs("StoreId").ToString() + " and isnull(Active,0)=1 and isnull(Deleted,0)=0 and (categoryid=" + catid.ToString() + " OR CategoryID in (SELECT DISTINCT items FROM dbo.GetParentcatgory(cast(" + catid.ToString() + " AS VARCHAR(50)),5)) )");
            if (dsBrandProductsall != null && dsBrandProductsall.Tables.Count > 0 && dsBrandProductsall.Tables[0].Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(dsBrandProductsall.Tables[0].Rows[0][0].ToString()) && Convert.ToInt32(dsBrandProductsall.Tables[0].Rows[0][0].ToString()) > 0)
                {
                    strcategory += "<li  class=\"categorydropdown active\"  onclick=\"showallcategory(this);\"><a href=\"javascript:void(0);\" style=\"font-weight:bold\">" + catname.ToString() + "(" + dsBrandProductsall.Tables[0].Rows[0][0].ToString() + ")</a>";
                }
                else
                {
                    strcategory += "<li  class=\"categorydropdown active\"  onclick=\"showallcategory(this);\"><a href=\"javascript:void(0);\" style=\"font-weight:bold\">" + catname.ToString() + "</a>";
                }
            }
            else
            {
                strcategory += "<li  class=\"categorydropdown active\"  onclick=\"showallcategory(this);\"><a href=\"javascript:void(0);\" style=\"font-weight:bold\">" + catname.ToString() + "</a>";
            }
            DataSet dsallcategorychild = new DataSet();
            dsallcategorychild = CommonBLL.GetCommonDataSet("SELECT name,Sename,tb_category.categoryId FROM tb_category INNER JOIN tb_CategoryMapping on tb_CategoryMapping.CategoryID=tb_category.CategoryID WHERE ParentCategoryID=" + catid + " and StoreId=" + AppLogic.AppConfigs("StoreId").ToString() + " and isnull(Active,0)=1 and isnull(Deleted,0)=0");
            if (dsallcategorychild != null && dsallcategorychild.Tables.Count > 0 && dsallcategorychild.Tables[0].Rows.Count > 0)
            {
                strcategory += "<ul>";
                for (int j = 0; j < dsallcategorychild.Tables[0].Rows.Count; j++)
                {
                    if (dsallcategorychild.Tables[0].Rows[j]["CategoryID"].ToString() != catid)
                    {
                        getcategory = true;

                        dsBrandProductsall = CommonBLL.GetCommonDataSet("SELECT  Distinct Count(Distinct tb_ProductCategory.ProductID) FROM tb_Product INNER JOIN tb_ProductCategory on tb_Product.ProductID=tb_ProductCategory.ProductID WHERE StoreId=" + AppLogic.AppConfigs("StoreId").ToString() + " and isnull(Active,0)=1 and isnull(Deleted,0)=0 and (categoryid=" + dsallcategorychild.Tables[0].Rows[j]["CategoryID"].ToString() + "  OR CategoryID in (SELECT DISTINCT items FROM dbo.GetParentcatgory(cast(" + dsallcategorychild.Tables[0].Rows[j]["CategoryID"].ToString() + " AS VARCHAR(50)),5)) )");
                        if (dsBrandProductsall != null && dsBrandProductsall.Tables.Count > 0 && dsBrandProductsall.Tables[0].Rows.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(dsBrandProductsall.Tables[0].Rows[0][0].ToString()) && Convert.ToInt32(dsBrandProductsall.Tables[0].Rows[0][0].ToString()) > 0)
                            {
                                strcategory += "<li  class=\"categorydropdown\"  onclick=\"showallcategory(this);\"><a href=\"/" + dsallcategorychild.Tables[0].Rows[j]["sename"].ToString() + ".html\">" + dsallcategorychild.Tables[0].Rows[j]["name"].ToString().Trim() + "(" + dsBrandProductsall.Tables[0].Rows[0][0].ToString() + ")</a>";
                                strcategory += "</li>";
                            }
                        }
                    }
                }
                strcategory += "</ul>";
            }

            strcategory += "</li></ul>";

            var storeId = AppLogic.AppConfigs("storeid");

            // ViewBag.Metatitle = AppLogic.AppConfigs("SiteSETitle").ToString();
            ViewBag.MetaDescription = dsallcategory.Tables[0].Rows[0]["SEDescription"].ToString();
            ViewBag.MetaKeywords = dsallcategory.Tables[0].Rows[0]["SEKeywords"].ToString();
            return new JsonResult { Data = strcategory, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
        public JsonResult CreateCookie(string productIds)
        {
            HttpCookie cookie = Request.Cookies["productIds"];
            String strCookieValue = "";
            if (cookie != null)
            {
                strCookieValue = cookie.Value.ToString();
            }
            if (string.IsNullOrEmpty(strCookieValue))
            {
                strCookieValue = ",";
            }
            if (strCookieValue.IndexOf("," + productIds + ",") <= -1)
            {
                strCookieValue = strCookieValue + productIds.ToString() + ",";
            }

            System.Web.HttpCookie custCookie = new System.Web.HttpCookie("productIds", strCookieValue);
            custCookie.Expires = DateTime.Now.AddYears(1);
            Response.Cookies.Add(custCookie);

            var jsonResultall = new { comaprecount = strCookieValue.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Length.ToString() };
            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }
        public JsonResult RemoveCookie(string productIds)
        {
            HttpCookie cookie = Request.Cookies["productIds"];
            String strCookieValue = "";
            if (cookie != null)
            {
                strCookieValue = cookie.Value.ToString();
            }

            if (strCookieValue.IndexOf("," + productIds + ",") > -1)
            {
                strCookieValue = strCookieValue.Replace("," + productIds + ",", "");
            }
            System.Web.HttpCookie custCookie = new System.Web.HttpCookie("productIds", strCookieValue);
            custCookie.Expires = DateTime.Now.AddYears(1);
            Response.Cookies.Add(custCookie);

            var jsonResultall = new { comaprecount = strCookieValue.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Length.ToString() };
            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetCookie(string productIds)
        {
            HttpCookie cookie = Request.Cookies["productIds"];
            String strCookieValue = "";
            if (cookie != null)
            {
                strCookieValue = cookie.Value.ToString();
            }

            return new JsonResult { Data = strCookieValue, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
        public JsonResult SetUrlsession(string cid)
        {
            System.Web.HttpContext.Current.Session["parentId"] = cid.ToString();

            var jsonResultall = new { strGrid = "success" };

            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SetUrlsessioncategory(string cid, string pid, string color)
        {
            System.Web.HttpContext.Current.Session["parentId"] = cid.ToString();

            System.Web.HttpContext.Current.Session["ProductColor_" + pid.ToString()] = System.Web.HttpContext.Current.Server.UrlDecode(color.ToString());

            var jsonResultall = new { strGrid = "success" };

            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Getlistdata(string guidnew)
        {
            string strCategoryproductlist = "";

            if (Session["strCategoryproductlist" + guidnew] != null)
            {
                strCategoryproductlist = Session["strCategoryproductlist" + guidnew].ToString();
            }

            var jsonResultall = new { Categoryproductlist = strCategoryproductlist };
            return Json(jsonResultall, JsonRequestBehavior.AllowGet);
        }

        public string Getrating(decimal Avrageration)
        {
            decimal dd = 0;
            decimal ddnew = 0;
            if (Avrageration > 0)
            {
                dd = Math.Truncate(Avrageration);
                ddnew = Avrageration - dd;
            }

            string strRating = "";
            if (dd == Convert.ToDecimal(1))
            {

                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                if (ddnew > Convert.ToDecimal(0) && ddnew <= Convert.ToDecimal(0.25))
                {
                    //strRating += "<img  src=\"/images/25-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.25) && ddnew <= Convert.ToDecimal(0.50))
                {
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.50))
                {
                    //   strRating += "<img  src=\"/images/75-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else
                {
                    strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                }
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
            }
            else if (dd == Convert.ToDecimal(2))
            {

                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                if (ddnew > Convert.ToDecimal(0) && ddnew <= Convert.ToDecimal(0.25))
                {
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.25) && ddnew <= Convert.ToDecimal(0.50))
                {
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.50))
                {
                    //strRating += "<img  src=\"/images/75-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else
                {
                    strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                }

                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
            }
            else if (dd == Convert.ToDecimal(3))
            {

                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                if (ddnew > Convert.ToDecimal(0) && ddnew <= Convert.ToDecimal(0.25))
                {
                    //strRating += "<img  src=\"/images/25-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.25) && ddnew <= Convert.ToDecimal(0.50))
                {
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.50))
                {
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                    // strRating += "<img  src=\"/images/75-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                }
                else
                {
                    strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                }


                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
            }
            else if (dd == Convert.ToDecimal(4))
            {

                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                if (ddnew > Convert.ToDecimal(0) && ddnew <= Convert.ToDecimal(0.25))
                {
                    //strRating += "<img  src=\"/images/25-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.25) && ddnew <= Convert.ToDecimal(0.50))
                {
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else if (ddnew > Convert.ToDecimal(0.50))
                {
                    //strRating += "<img  src=\"/images/75-star.jpg\" alt=\"Rating\" title=\"Rating\" >";
                    strRating += "<i class=\"fa fa-star-half-full f-dark-red\"></i>";
                }
                else
                {
                    strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                }
            }
            else if (dd == Convert.ToDecimal(5))
            {
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star f-dark-red\"></i>";
            }
            else
            {
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
                strRating += "<i class=\"fa fa-star-o f-dark-red\"></i>";
            }
            return strRating;
        }

        public string GetMenuIconImageBrand(String img)
        {
            String imagepath = String.Empty;
            imagepath = AppLogic.AppConfigs("BrandBlackLogoPath") + img;
            return imagepath;
        }

        public string CalculatePrice(DataSet Productlist, int i)
        {
            string strprice = "";
            Decimal price = Convert.ToDecimal(Productlist.Tables[0].Rows[i]["price"].ToString());
            Decimal saleprice = Convert.ToDecimal(Productlist.Tables[0].Rows[i]["saleprice"].ToString());
            if (Convert.ToBoolean(Productlist.Tables[0].Rows[i]["IsSpecialBrand"]))
            {
                if (Convert.ToBoolean(Productlist.Tables[0].Rows[i]["Discontinue"]))
                {
                    if (saleprice > 0 && saleprice < price)
                    {
                        strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong><del>" + price.ToString("C") + "</del></strong><strong style=\"padding-left: 10px;\"><span>" + saleprice.ToString("C") + "</span></strong>###colors###</div>";
                    }
                    else
                    {
                        strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong style=\"padding-left: 10px;\"><span>" + price.ToString("C") + "</span></strong>###colors###</div>";
                    }
                }
                else if (System.Web.HttpContext.Current.Session["UserName"] != null)
                {
                    if (saleprice > 0 && saleprice < price)
                    {
                        strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong><del>" + price.ToString("C") + "</del></strong><strong style=\"padding-left: 10px;\"><span>" + saleprice.ToString("C") + "</span></strong>###colors###</div>";
                    }
                    else
                    {
                        strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong style=\"padding-left: 10px;\"><span>" + saleprice.ToString("C") + "</span></strong>###colors###</div>";
                    }
                }
                else
                {
                    strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong style=\"padding-left: 10px;\"><span>" + price.ToString("C") + "</span></strong>###colors###</div>";
                }
            }
            else
            {
                if (saleprice > 0 && saleprice < price)
                {
                    strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong><del>" + price.ToString("C") + "</del></strong><strong style=\"padding-left: 10px;\"><span>" + saleprice.ToString("C") + "</span></strong>###colors###</div>";
                }
                else
                {
                    strprice += "<div class=\"most-wanted-pro-price l-h-24\"><strong style=\"padding-left: 10px;\"><span>" + saleprice.ToString("C") + "</span></strong>###colors###</div>";
                }
            }
            return strprice;
        }
    }
}