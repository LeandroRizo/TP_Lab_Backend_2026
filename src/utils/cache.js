// Caché en memoria con TTL (Time-To-Live) e invalidación selectiva por prefijo/clave para reportes

const store = new Map();
const DEFAULT_TTL_MS = 60 * 1000; // 60 segundos

export const obtenerCache = (clave) => {
    const entrada = store.get(clave);
    if (!entrada) return null;

    if (Date.now() > entrada.expiraEn) {
        store.delete(clave);
        return null;
    }

    return entrada.valor;
};

export const guardarCache = (clave, valor, ttlMs = DEFAULT_TTL_MS) => {
    store.set(clave, {
        valor,
        expiraEn: Date.now() + ttlMs
    });
    return valor;
};

export const invalidarCache = (...prefijos) => {
    const lista = prefijos.filter(Boolean);
    if (lista.length === 0) {
        store.clear();
        return;
    }
    for (const clave of store.keys()) {
        if (lista.some((prefijo) => clave.startsWith(prefijo))) {
            store.delete(clave);
        }
    }
};

export default {
    obtenerCache,
    guardarCache,
    invalidarCache
};
