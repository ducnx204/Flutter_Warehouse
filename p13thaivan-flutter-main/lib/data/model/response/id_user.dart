class IdUser {
	bool? isEmailVerified;
	String? idUser;
	String? idRole;
	String? idOptionalRole;
	String? fullname;
	String? username;
	String? sex;
	String? avatar;
	String? born;
	String? phone;
	String? address;
	String? citizenIdentification;
	String? status;
	String? imageCitizenIdentification;
	String? imageCitizenIdentification1;
	String? paymentProofImage;
	String? createdAt;
	String? updatedAt;
	String? id;

	IdUser({
		this.isEmailVerified, 
		this.idUser, 
		this.idRole, 
		this.idOptionalRole, 
		this.fullname, 
		this.username, 
		this.sex, 
		this.avatar, 
		this.born, 
		this.phone, 
		this.address, 
		this.citizenIdentification, 
		this.status, 
		this.imageCitizenIdentification, 
		this.imageCitizenIdentification1, 
		this.paymentProofImage, 
		this.createdAt, 
		this.updatedAt, 
		this.id, 
	});

	factory IdUser.fromJson(Map<String, dynamic> json) => IdUser(
				isEmailVerified: json['isEmailVerified'] as bool?,
				idUser: json['idUser'] as String?,
				idRole: json['idRole'] as String?,
				idOptionalRole: json['idOptionalRole'] as String?,
				fullname: json['fullname'] as String?,
				username: json['username'] as String?,
				sex: json['sex'] as String?,
				avatar: json['avatar'] as String?,
				born: json['born'] as String?,
				phone: json['phone'] as String?,
				address: json['address'] as String?,
				citizenIdentification: json['citizenIdentification'] as String?,
				status: json['status'] as String?,
				imageCitizenIdentification: json['imageCitizenIdentification'] as String?,
				imageCitizenIdentification1: json['imageCitizenIdentification1'] as String?,
				paymentProofImage: json['paymentProofImage'] as String?,
				createdAt: json['created_at'] as String?,
				updatedAt: json['updated_at'] as String?,
				id: json['id'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'isEmailVerified': isEmailVerified,
				'idUser': idUser,
				'idRole': idRole,
				'idOptionalRole': idOptionalRole,
				'fullname': fullname,
				'username': username,
				'sex': sex,
				'avatar': avatar,
				'born': born,
				'phone': phone,
				'address': address,
				'citizenIdentification': citizenIdentification,
				'status': status,
				'imageCitizenIdentification': imageCitizenIdentification,
				'imageCitizenIdentification1': imageCitizenIdentification1,
				'paymentProofImage': paymentProofImage,
				'created_at': createdAt,
				'updated_at': updatedAt,
				'id': id,
			};
}
