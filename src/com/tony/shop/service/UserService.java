package com.tony.shop.service;
import com.tony.shop.dao.*;
import com.tony.shop.model.User;

public class UserService {
	User user = new User();
	UserDao dao = new UserDaoImpl();
	
	public UserService(User x){
		user = x;
	}
	
	public UserService() {
	}

	public boolean login(){

		return dao.login(user);
	}
	
	public boolean register(){
		return dao.insert(user);
	}
	
	public User getInfo(String name){
		return dao.search(name);
	}
	
	public void changeValue(String username, String valuename, String value){
		dao.changeValue(username, valuename, value);
		
	}
	
	public boolean addPet(String name, int petId){
		user = getInfo(name);
		String oldpets = user.getPets();
		String idString = Integer.toString(petId);
		String newpets = "";
		
		boolean addable = true;
		
		if (!oldpets.equals("")){
			String[] animalsArray = oldpets.split(",");
			for (String element : animalsArray){
				if(element.equals(idString)){
					addable = false;
				}
			}
			if (addable == true){
				newpets = oldpets + "," + petId;
				dao.changeValue(name, "Pets", newpets);
			}
		} else {
			newpets = idString;
			dao.changeValue(name, "Pets", newpets);
		}
		
		return addable;
		
	}
	
	public String getPets(String name){
		user = getInfo(name);
		return user.getPets();
	}
	
	public void deletePet(String name, String Id){
		user = getInfo(name);
		String oldpets = user.getPets();
		String[] petsArray = oldpets.split(",");
		String newpets = "";
		if (petsArray.length > 1){
			for (int i = 0; i < petsArray.length; i++){
				if (!petsArray[i].equals(Id)){
					newpets = newpets + petsArray[i] + ",";
				}
			}
			newpets = newpets.substring(0, newpets.length()-1);
		}
		changeValue(name, "Pets", newpets);
	}
	
	public boolean checkUnique(String name){
		return dao.checkUnique(name);
	}
	
	public String getAddress(String name){
		return dao.getAdd(name);
	}
}
