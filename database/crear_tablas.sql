-- Laboratorio #3: Sistema de inventario aduanero
-- Gestor: PostgreSQL en Supabase
-- Integrante(s): Ana María Ocampo Esquivel
-- Fecha: 2026-10-23

BEGIN;

CREATE TABLE importador (
    id_importador SERIAL PRIMARY KEY,
    razon_social VARCHAR(150) NOT NULL,
    identificacion VARCHAR(30) NOT NULL UNIQUE,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(25),
    correo VARCHAR(120) UNIQUE
);

CREATE TABLE agente_aduanal (
    id_agente SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    numero_licencia VARCHAR(40) NOT NULL UNIQUE,
    telefono VARCHAR(25)
);

CREATE TABLE pais (
    id_pais SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    codigo_iso CHAR(2) NOT NULL UNIQUE
);

CREATE TABLE partida_arancelaria (
    id_partida SERIAL PRIMARY KEY,
    codigo VARCHAR(12) NOT NULL UNIQUE,
    descripcion VARCHAR(200) NOT NULL,
    porcentaje_arancel DECIMAL(5,2) NOT NULL DEFAULT 0,
    CONSTRAINT chk_porcentaje_arancel
        CHECK (porcentaje_arancel >= 0 AND porcentaje_arancel <= 100)
);

CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL,
    unidad_medida VARCHAR(30) NOT NULL,
    valor_unitario DECIMAL(12,2) NOT NULL DEFAULT 0,
    id_partida INTEGER NOT NULL,
    CONSTRAINT chk_valor_unitario CHECK (valor_unitario >= 0),
    CONSTRAINT fk_producto_partida
        FOREIGN KEY (id_partida)
        REFERENCES partida_arancelaria(id_partida)
);

CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    cargo VARCHAR(80) NOT NULL,
    id_supervisor INTEGER,
    CONSTRAINT chk_supervisor_distinto
        CHECK (id_supervisor IS NULL OR id_supervisor <> id_funcionario),
    CONSTRAINT fk_funcionario_supervisor
        FOREIGN KEY (id_supervisor)
        REFERENCES funcionario(id_funcionario)
        ON DELETE SET NULL
);

CREATE TABLE bodega (
    id_bodega SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    ubicacion VARCHAR(150) NOT NULL,
    capacidad_kg DECIMAL(14,2) NOT NULL,
    CONSTRAINT chk_capacidad_bodega CHECK (capacidad_kg > 0)
);

CREATE TABLE declaracion (
    id_declaracion SERIAL PRIMARY KEY,
    numero VARCHAR(30) NOT NULL UNIQUE,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    regimen VARCHAR(15) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Registrada',
    id_importador INTEGER NOT NULL,
    id_agente INTEGER NOT NULL,
    id_pais_origen INTEGER NOT NULL,
    CONSTRAINT chk_regimen
        CHECK (regimen IN ('Importacion', 'Exportacion', 'Transito', 'Deposito')),
    CONSTRAINT chk_estado_declaracion
        CHECK (estado IN ('Registrada', 'En revision', 'Retenida', 'Liberada', 'Rechazada')),
    CONSTRAINT fk_declaracion_importador
        FOREIGN KEY (id_importador) REFERENCES importador(id_importador),
    CONSTRAINT fk_declaracion_agente
        FOREIGN KEY (id_agente) REFERENCES agente_aduanal(id_agente),
    CONSTRAINT fk_declaracion_pais
        FOREIGN KEY (id_pais_origen) REFERENCES pais(id_pais)
);

CREATE TABLE detalle_declaracion (
    id_declaracion INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad DECIMAL(12,2) NOT NULL,
    valor_declarado DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (id_declaracion, id_producto),
    CONSTRAINT chk_cantidad_detalle CHECK (cantidad > 0),
    CONSTRAINT chk_valor_declarado CHECK (valor_declarado >= 0),
    CONSTRAINT fk_detalle_declaracion
        FOREIGN KEY (id_declaracion) REFERENCES declaracion(id_declaracion),
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE contenedor (
    id_contenedor SERIAL PRIMARY KEY,
    numero VARCHAR(30) NOT NULL UNIQUE,
    tipo VARCHAR(40) NOT NULL,
    peso_kg DECIMAL(12,2) NOT NULL,
    id_declaracion INTEGER NOT NULL,
    CONSTRAINT chk_peso_contenedor CHECK (peso_kg > 0),
    CONSTRAINT fk_contenedor_declaracion
        FOREIGN KEY (id_declaracion) REFERENCES declaracion(id_declaracion)
);

CREATE TABLE inventario_bodega (
    id_bodega INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad DECIMAL(12,2) NOT NULL DEFAULT 0,
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_DATE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Retenido',
    PRIMARY KEY (id_bodega, id_producto),
    CONSTRAINT chk_cantidad_inventario CHECK (cantidad >= 0),
    CONSTRAINT chk_estado_inventario
        CHECK (estado IN ('Retenido', 'Liberado', 'En inspeccion')),
    CONSTRAINT fk_inventario_bodega
        FOREIGN KEY (id_bodega) REFERENCES bodega(id_bodega),
    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE inspeccion (
    id_inspeccion SERIAL PRIMARY KEY,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    resultado VARCHAR(30) NOT NULL,
    observaciones TEXT,
    id_declaracion INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    CONSTRAINT chk_resultado_inspeccion
        CHECK (resultado IN ('Aprobada', 'Con observaciones', 'Rechazada', 'Pendiente')),
    CONSTRAINT fk_inspeccion_declaracion
        FOREIGN KEY (id_declaracion) REFERENCES declaracion(id_declaracion),
    CONSTRAINT fk_inspeccion_funcionario
        FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE movimiento_inventario (
    id_movimiento SERIAL PRIMARY KEY,
    tipo VARCHAR(15) NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    cantidad DECIMAL(12,2) NOT NULL,
    id_producto INTEGER NOT NULL,
    id_bodega INTEGER NOT NULL,
    CONSTRAINT chk_tipo_movimiento
        CHECK (tipo IN ('Entrada', 'Salida', 'Traslado')),
    CONSTRAINT chk_cantidad_movimiento CHECK (cantidad > 0),
    CONSTRAINT fk_movimiento_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_movimiento_bodega
        FOREIGN KEY (id_bodega) REFERENCES bodega(id_bodega)
);

COMMIT;