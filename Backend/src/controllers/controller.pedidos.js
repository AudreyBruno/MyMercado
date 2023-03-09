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

controllerPedidos.post("/pedidos", function(request, response){
    db.getConnection(function(err, conn){
        conn.beginTransaction(function(err){
            const {id_mercado, id_usuario, vl_subtotal, vl_entrega,vl_total, endereco, bairro, cidade, uf, cep} = request.body;


            let ssql = "INSERT INTO pedido (id_mercado, id_usuario, dt_pedido, vl_subtotal, vl_entrega,"
            ssql += " vl_total, endereco, bairro, cidade, uf, cep)";
            ssql += " VALUES(?, ?, CURRENT_TIMESTAMP(), ?, ?, ?, ?, ?, ?, ?, ?)";
            

            conn.query(ssql, [id_mercado, id_usuario, vl_subtotal, vl_entrega,vl_total, endereco, bairro, cidade, uf, cep], function(err, result) {
                if (err) {
                    conn.rollback();
                    return response.status(500).send(err);
                } else {            
                    let id_pedido = result.insertId;
                    let valuesPedidoItem = [];

                    request.body.itens.map(function(item){
                        valuesPedidoItem.push([id_pedido, item.id_produto, item.qtd, item.vl_unitario, item.vl_total]);
                    });

                    let ssql = "INSERT INTO pedido_item (id_pedido, id_produto, qtd, vl_unitario, vl_total)";
                    ssql += " VALUES ?";
                    
                    conn.query(ssql, [valuesPedidoItem], function(err, result){
                        conn.release();

                        if (err) {
                            conn.rollback();
                            return response.status(500).send(err);
                        } else {
                            conn.commit();
                            return response.status(201).json({id_pedido});
                        }
                    });
                }
            });
        })
    });
});

export default controllerPedidos;