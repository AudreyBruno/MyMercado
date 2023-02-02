import { Router } from "express";
import db from "../config/database.js";

const controllerPedidos = Router();

controllerPedidos.get("/pedidos/:id_pedido", function(request, response){
    let ssql = "SELECT * FROM pedido WHERE id_pedido = ?";

    db.query(ssql, request.params.id_pedido, function(err, result) {
        if (err) {
            return response.status(500).send(err);
        } else {            
            return response.status(result.length > 0 ? 200 : 404).json(result);
        }
    });
});

export default controllerPedidos;