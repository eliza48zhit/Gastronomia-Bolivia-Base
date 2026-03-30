// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaBolivia
 * @dev Registro historico con Likes, Dislikes e Identificador de Tecnica de Coccion.
 */
contract GastronomiaBolivia {

    struct Plato {
        string nombre;
        string descripcion;
        string coccion; // Ej: Horneado de Piedra, Salteado al Fuego, Hervido Lento
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con la Salteña Boliviana
        registrarPlato(
            "Saltena", 
            "Empanada jugosa rellena de guiso de carne o pollo con papa y caldo, de masa dulce.",
            "Horneado"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _coccion
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            coccion: _coccion,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory coccion,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.coccion, p.likes, p.dislikes);
    }
}
