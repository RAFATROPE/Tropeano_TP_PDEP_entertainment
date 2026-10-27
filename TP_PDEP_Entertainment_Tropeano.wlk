class Entrada {
    var property precio = 1000
    const property banda
    const property fecha

    method precioConImpuesto() {
        return precio + productora.impuesto()
    }
}

const entrada = new Entrada(banda = "ACDC",fecha = new Date(day = 23, month = 6, year = 2026))
class Asistente {
    var property historialEntradas = []
    var property dineroDisponible
    var property abonoAsistente

    method comprarEntrada(entrada) {
        if (dineroDisponible >= abonoAsistente.aplicarDescuento(entrada) and dineroDisponible > 0) {
            dineroDisponible = dineroDisponible - abonoAsistente.aplicarDescuento(entrada)
            historialEntradas.add(entrada)
            productora.entradasCompradas().add(entrada)
            productora.ganancias(productora.ganancias() + entrada.precioConImpuesto())
            entrada.banda().registrarVenta()
        } else {
            self.error("no hay suficiente dinero para comprar la entrada")
        }
    }
    method verEntradasAñoPasado() {
        return historialEntradas.filter({unaEntrada => calendario.añoActual() - unaEntrada.fecha().year() == 1 })
    }

    method verNombreDeBandas() {
        return historialEntradas.map({unaEntrada => unaEntrada.banda().nombre()})
    }
}
object fan {
    const property abono = "Fan"

    method aplicarDescuento(entrada) {
        return entrada.precioConImpuesto()
    }

}

class Vip {
    const property abono = "VIP"
    var property descuento

    method aplicarDescuento(entrada) {
        return entrada.precioConImpuesto() - (entrada.precioConImpuesto() * descuento)
    }

    method bonificar() {
        descuento = descuento + 0.01
    }
}

object calendario {
    var property añoActual = 2026

    method añoAnterior() {
        return añoActual - 1
    }

    method pasarAño() {
        añoActual = añoActual + 1
    }
}

const asistente1 = new Asistente(abonoAsistente = new Vip (descuento = 0.5), dineroDisponible = -100)
const asistente2 = new Asistente(abonoAsistente = fan, dineroDisponible = 2000)

class Banda {
    const property nombre
    var property canon = 1000000
    var property entradasVendidas = 0

    method registrarVenta() {
        entradasVendidas = entradasVendidas + 1
    }
}

class BandaRock inherits Banda {
    var property solosDeGuitarra

    method presupuesto() {
        return canon + 10000
    }

    method popularidad() {
        return 100 * solosDeGuitarra
    }
}

const acdc = new BandaRock(nombre = "ACDC", solosDeGuitarra = 5)

class BandaTrap inherits Banda {
    const property hielo


    method popularidad() {
        if (hielo) {
            return 1000
        } else {
            return 0
        }
    }

    method presupuesto() {
            return canon * self.popularidad()
    }
}

const facilB = new BandaTrap(nombre = "facilB", hielo = true)

class BandaIndie inherits Banda {
    const property largoDelNombre = nombre.length()
    var property cantidadDeInstrumentos

    method popularidad() {
        return largoDelNombre * 3.14
    }

    method presupuesto() {
        return canon + (500*cantidadDeInstrumentos)
    }
}

object productora {
    var property impuesto = 500
    var property entradasCompradas = []
    var property ganancias = 0 
    var property bandas = []

    method gananciaTotal() {
        return ganancias - bandas.sum({unaBanda => unaBanda.presupuesto()})
    }

    method cantidadEntradasVendidas() {
        return entradasCompradas.size()
    }

    method bandaMasPopular() {
        return bandas.max({unaBanda => unaBanda.entradasVendidas()})
    }

    method bonificarA(unVip) {
        unVip.bonificar()
    }
}