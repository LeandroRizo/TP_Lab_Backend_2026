import { 
    getProductos, 
    getProductoById, 
    crearProducto, 
    actualizarProducto as actualizarProductoService,
    eliminarProducto as eliminarProductoService
} from "../services/producto.service.js"; 


export const obtenerProductos = async (req, res) => { 

    try { 
        const productos = await getProductos(); 
        res.status(200).json(productos); 

    } catch (error) { 
        res.status(500).json({ 
            error: "Error al obtener los productos" 
        }); 
    }
};


export const obtenerProductoPorId = async (req, res) => { 

    try {
        const producto = await getProductoById(req.params.id); 

        if (!producto) { 
            return res.status(404).json({ 
                error: "Producto no encontrado" 
            }); 
        } 

        res.status(200).json(producto); 

    } catch (error) {
        res.status(500).json({ 
            error: "Error al obtener el producto" 
        });
    }
};


export const crearNuevoProducto = async (req, res) => { 

    try { 
        const nuevoProducto = await crearProducto(req.body);
        res.status(201).json(nuevoProducto);

    } catch (error) { 
        res.status(500).json({ 
            error: "Error al crear el producto" 
        }); 
    }
};


export const actualizarProducto = async (req, res) => { 

    try { 
        const productoActualizado = await actualizarProductoService(
            req.params.id, 
            req.body
        );

        res.status(200).json(productoActualizado); 

    } catch (error) { 
        res.status(500).json({ 
            error: "Error al actualizar el producto" 
        }); 
    }
};


export const eliminarProducto = async (req, res) => { 

    try { 
        await eliminarProductoService(req.params.id);
        res.status(200).json({ 
            message: "Producto eliminado correctamente" 
        });

    } catch (error) { 
        res.status(500).json({ 
            error: "Error al eliminar el producto" 
        }); 
    }
};