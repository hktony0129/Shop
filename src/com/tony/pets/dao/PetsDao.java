package com.tony.pets.dao;

import com.tony.pets.model.Pet;
import java.util.List;

public interface PetsDao {
	public List<Pet> search(String type, String breed, int ageLow, int ageHigh, int page);
	public List<Pet> getById(String Id);
	public int getSize(String type, String breed, int ageLow, int ageHigh);
	public List<String> getType();
}
