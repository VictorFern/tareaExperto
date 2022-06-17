using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
namespace proyecto_expertos_api.Model
{
    public class Oferta
    {
        public int id { get; set; }
        public int precio { get; set; }
        public SitiosTuristicos SitiosTuristicos { get; set; }
    }
}
