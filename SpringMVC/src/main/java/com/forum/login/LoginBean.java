package com.forum.login;
public class LoginBean {
    private String username;
    private String password;
    private String userId;
    private int userIdentity;
    private int blockForbidden;

    public int getBlockForbidden() {
		return blockForbidden;
	}

	public void setBlockForbidden(int blockForbidden) {
		this.blockForbidden = blockForbidden;
	}

	public LoginBean(){}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getUserIdentity() {
		return userIdentity;
	}

	public void setUserIdentity(int userIdentity) {
		this.userIdentity = userIdentity;
	}

	public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
