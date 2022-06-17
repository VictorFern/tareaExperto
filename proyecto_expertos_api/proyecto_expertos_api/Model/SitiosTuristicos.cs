using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
namespace proyecto_expertos_api.Model
{
    public class SitiosTuristicos
    {
        public int id { get; set; }
        public string titulo { get; set; }
        public string descripcion { get; set; }
        public int precio { get; set; }
        public string imagen { get; set; }
        public Localidad Localidad { get; set; }
    }
}
