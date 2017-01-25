package com.tony.pets.service;

import java.util.List;

import com.tony.pets.dao.PetsDao;
import com.tony.pets.dao.PetsDaoImpl;
import com.tony.pets.model.Pet;

public class PetsService {
	PetsDao dao = new PetsDaoImpl();
	
	public List<Pet> getById(String Ids) {
		return dao.getById(Ids);
	}
	
}
