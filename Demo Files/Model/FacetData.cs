using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EyeGlasses.Models
{
    public class FacetData
    {    
        public int manufacturerId { get; set; }
        public int newcatid { get; set; }
        public int tabid { get; set; }
        public int startRow { get; set; }
        public int endRow { get; set; }
        public string guidenew { get; set; }
        public string url { get; set; }
        
        public string sortby { get; set; }
        public bool isAvailablePrescription { get; set; }
        public bool isPolarized { get; set; }
        public bool isInStock { get; set; }

        public string gender { get; set; }
        public string brand { get; set; }
        public string category { get; set; }
        public string frameType { get; set; }
        public string frameShape { get; set; }
        public string lensColor { get; set; }
        public string frameColor { get; set; }
    }
}