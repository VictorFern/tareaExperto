using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using proyecto_expertos_api.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace proyecto_expertos_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TareaController : ControllerBase
    {
        private readonly IConfiguration Configuration;

        public TareaController(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        [Route("Lista")]
        [HttpGet]
        public async Task<ActionResult<List<SitiosTuristicos>>> Lista()
        {
            List<SitiosTuristicos> lista = new List<SitiosTuristicos>();
            SqlConnection cn = new SqlConnection(Configuration.GetConnectionString("Default"));
            var cmd = new SqlCommand("sp_MOSTRAR_SITIOS", cn);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cn.Open();
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    SitiosTuristicos sitiosTuristicos = new SitiosTuristicos();
                    Localidad localidad = new Localidad();
                    DataRow dr = dt.Rows[i];
                    string[] allColumns = dr.ItemArray.Select(obj => obj.ToString()).ToArray();
                    ArrayList itm = new ArrayList(allColumns);

                    sitiosTuristicos.id = Int32.Parse(itm[0].ToString());
                    sitiosTuristicos.titulo = itm[1].ToString();
                    sitiosTuristicos.descripcion = itm[2].ToString();
                    sitiosTuristicos.precio = Int32.Parse(itm[3].ToString());
                    sitiosTuristicos.imagen = itm[4].ToString();
                    localidad.id = Int32.Parse(itm[5].ToString());
                    localidad.localidad = itm[6].ToString();
                    localidad.image = itm[7].ToString();
                    sitiosTuristicos.Localidad = localidad;

                    lista.Add(sitiosTuristicos);
                }
            }
            cn.Close();
            return lista;
        }
        [Route("Ofertas")]
        [HttpGet]
        public async Task<ActionResult<List<Oferta>>> listaOfertas()
        {
            List<Oferta> lista = new List<Oferta>();
            SqlConnection cn = new SqlConnection(Configuration.GetConnectionString("Default"));
            var cmd = new SqlCommand("sp_MOSTRAR_OFERTAS", cn);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cn.Open();
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    SitiosTuristicos sitiosTuristicos = new SitiosTuristicos();
                    Localidad localidad = new Localidad();
                    Oferta oferta = new Oferta();
                    DataRow dr = dt.Rows[i];
                    string[] allColumns = dr.ItemArray.Select(obj => obj.ToString()).ToArray();
                    ArrayList itm = new ArrayList(allColumns);

                    sitiosTuristicos.id = Int32.Parse(itm[0].ToString());
                    sitiosTuristicos.titulo = itm[1].ToString();
                    sitiosTuristicos.descripcion = itm[2].ToString();
                    sitiosTuristicos.precio = Int32.Parse(itm[3].ToString());
                    sitiosTuristicos.imagen = itm[4].ToString();
                    localidad.id = Int32.Parse(itm[5].ToString());
                    localidad.localidad = itm[6].ToString();
                    localidad.image = itm[7].ToString();
                    sitiosTuristicos.Localidad = localidad;
                    oferta.id = Int32.Parse(itm[8].ToString());
                    oferta.precio = Int32.Parse(itm[9].ToString());
                    oferta.SitiosTuristicos = sitiosTuristicos;
                    lista.Add(oferta);
                }
            }
            cn.Close();
            return lista;
        }
    }
}
