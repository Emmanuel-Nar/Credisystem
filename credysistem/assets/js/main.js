
function calcularCuotas(event) {
    event.preventDefault();

    let monto = parseFloat(document.getElementById("monto").value);

    let cuota3 = (monto * 1.25) / 3;
    let cuota6 = (monto * 1.50) / 6;
    let cuota9 = (monto * 1.75) / 9;
    let cuota12 = (monto * 2.20) / 12;


    document.getElementById("cuota3").textContent = cuota3.toFixed(2);
    document.getElementById("cuota6").textContent = cuota6.toFixed(2);
    document.getElementById("cuota9").textContent = cuota9.toFixed(2);
    document.getElementById("cuota12").textContent = cuota12.toFixed(2);


    document.getElementById("resultados").classList.remove('d-none');
}




function calcularInteresCompuesto(event) {
    event.preventDefault();

    let monto = parseFloat(document.getElementById("monto").value);
    let tasaInteres = 0.005;
    let fechaVencimiento = new Date(document.getElementById("fechaVencimiento").value);
    let fechaActual = new Date();
    let diasRetraso = Math.floor((fechaActual - fechaVencimiento) / (1000 * 60 * 60 * 24));


    let alertaError = document.getElementById("alertaError");
    let resultados = document.getElementById("resultados");
    alertaError.classList.add('d-none');
    alertaError.innerHTML = "";
    resultados.classList.add('d-none');


    if (diasRetraso < 0) {
        alertaError.classList.remove('d-none');
        alertaError.innerHTML = "La fecha de vencimiento es posterior a la fecha actual. Por favor, elige una fecha válida.";
        return;
    }


    if (diasRetraso > 90) {
        alertaError.classList.remove('d-none');
        alertaError.innerHTML = "Han pasado más de 90 días desde la fecha de tu primer vencimiento. Por favor, comunícate al teléfono: <strong>341-6365506</strong>";
        return;
    }


    let montoFinal = monto * Math.pow((1 + tasaInteres), diasRetraso);


    let interesAcumulado = montoFinal - monto;


    document.getElementById("diasMora").textContent = diasRetraso;
    document.getElementById("interesAcumulado").textContent = interesAcumulado.toFixed(2);
    document.getElementById("montoTotal").textContent = montoFinal.toFixed(2);

    resultados.classList.remove('d-none');
}

function abonar() {
    alert("GENIAL! ya estas al día sabias que puedes renovar tu crédito?");
}

function comunicarse() {
    alert("Por favor, comunícate al teléfono: <strong>341-6365506</strong> ");
}


function calcularCuotas(event) {
    event.preventDefault();

    const monto = parseFloat(document.getElementById("monto").value);
    if (isNaN(monto) || monto <= 0) return;

    document.getElementById("cuota3").innerText = (monto / 3).toFixed(2);
    document.getElementById("cuota6").innerText = (monto / 6).toFixed(2);
    document.getElementById("cuota9").innerText = (monto / 9).toFixed(2);
    document.getElementById("cuota12").innerText = (monto / 12).toFixed(2);

    document.getElementById("resultados").classList.remove("d-none");
}

function abrirModal(cuotas, valor) {
    document.getElementById("cuotaSeleccionada").innerText = cuotas;
    document.getElementById("valorSeleccionado").innerText = valor;

    const modal = new bootstrap.Modal(document.getElementById('cuotaModal'));
    modal.show();
}

function continuarTramite() {
    alert("Perfecto ✅ ¡Continuamos con tu trámite!");

}


//creditos js
const saldoDisponible = 100000;
const montoInput = document.getElementById('monto');
const plazoSelect = document.getElementById('plazo');
const cuotaInfo = document.getElementById('cuotaInfo');
const valorCuota = document.getElementById('valorCuota');
const resultado = document.getElementById('resultado');
const form = document.getElementById('creditoForm');


montoInput.addEventListener('input', () => {
    if (parseFloat(montoInput.value) > saldoDisponible) {
        montoInput.value = saldoDisponible;
    }
});


plazoSelect.addEventListener('change', () => {
    const monto = parseFloat(montoInput.value);
    const plazo = parseInt(plazoSelect.value);

    if (!monto || monto <= 0 || !plazo) {
        cuotaInfo.style.display = 'none';
        return;
    }

    let porcentajeExtra = 0;
    switch (plazo) {
        case 6: porcentajeExtra = 0.45; break;
        case 12: porcentajeExtra = 0.75; break;
        case 24: porcentajeExtra = 1.20; break;
        case 36: porcentajeExtra = 1.75; break;
        default: porcentajeExtra = 0; break;
    }

    const totalConInteres = monto + (monto * porcentajeExtra);
    const valorDeCuota = (totalConInteres / plazo).toFixed(2);

    valorCuota.textContent = `$${valorDeCuota} (${plazo} cuotas)`;
    cuotaInfo.style.display = 'block';
});


form.addEventListener('submit', function (e) {
    e.preventDefault();

    const monto = parseFloat(montoInput.value);
    const plazo = parseInt(plazoSelect.value);

    if (monto > saldoDisponible) {
        resultado.className = 'alert alert-danger result-box';
        resultado.innerText = 'Error: El monto solicitado excede tu saldo disponible.';
    } else if (monto < 1000) {
        resultado.className = 'alert alert-warning result-box';
        resultado.innerText = 'El monto mínimo para solicitar es $1,000.';
    } else {
        const estados = ['Aprobada', 'En revisión', 'Rechazada'];
        const estado = estados[Math.floor(Math.random() * estados.length)];
        resultado.className = 'alert alert-info result-box';
        resultado.innerText = `Tu solicitud ha sido enviada. Estado: ${estado}`;
    }

    resultado.style.display = 'block';
});


//cuotas
const tieneCreditoActivo = true;
const modal = new bootstrap.Modal(document.getElementById('modalPago'));
let cuotaSeleccionada = null;
let montoSeleccionado = 0;

if (!tieneCreditoActivo) {
    document.getElementById('resumenCredito').style.display = 'none';
    document.getElementById('cuotasPendientes').style.display = 'none';
    document.getElementById('historialPagos').style.display = 'none';
    document.getElementById('sinCredito').style.display = 'block';
}

function abrirPago(num, monto) {
    cuotaSeleccionada = num;
    montoSeleccionado = monto;
    document.getElementById('numCuota').innerText = num;
    document.getElementById('montoCuota').innerText = monto.toLocaleString();
    modal.show();
}

function confirmarPago() {
    const metodo = document.getElementById('metodoPago').value;
    if (!metodo) {
        alert('Por favor, seleccioná un método de pago.');
        return;
    }
    alert(`✅ Pago confirmado para la cuota N°${cuotaSeleccionada} por $${montoSeleccionado.toLocaleString()} mediante ${metodo === "debito" ? "Débito automático" : metodo === "pagoFacil" ? "Pago Fácil" : "Tarjeta de crédito"}.`);
    modal.hide();
}
