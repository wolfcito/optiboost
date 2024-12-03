// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// Importación de Ownable de OpenZeppelin
import "@openzeppelin/contracts/access/Ownable.sol";

contract CommunityDonations is Ownable {
	// Registro de balances de los donantes
	mapping(address => uint256) public donorBalances;

	// Evento emitido cuando se recibe una donación
	event DonationReceived(address indexed donor, uint256 amount);

	// Constructor
	constructor() Ownable() {}

	// Función para donar ETH
	function donate() external payable {
		require(msg.value > 0, "Deberia enviar una cantidad mayor a 0");
		donorBalances[msg.sender] += msg.value;
		emit DonationReceived(msg.sender, msg.value);
	}

	// Función para retirar fondos (solo propietario)
	function withdraw() external onlyOwner {
		require(address(this).balance > 0, "No hay fondos para retirar");
		payable(owner()).transfer(address(this).balance);
	}
}
