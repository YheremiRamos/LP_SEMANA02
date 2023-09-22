package com.empresa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.empresa.entity.Proveedor;
import com.empresa.repository.ProveedorRepository;

@Service
public class ProveedorServicelpml implements ProveedorService {
		

	@Autowired
	private ProveedorRepository repository;
	
	@Override
	public Proveedor insertaProveedor(Proveedor obj) {
		return repository.save(obj);
	}
//3
	@Override
	public List<Proveedor> listaPorNombre(String nombre){
		return repository.findByNombreIgnoreCase(nombre);
	}
	
	@Override
	public List<Proveedor> listaPorDni(String dni){
		return repository.findByDniIgnoreCase(dni);
	}
	
}
