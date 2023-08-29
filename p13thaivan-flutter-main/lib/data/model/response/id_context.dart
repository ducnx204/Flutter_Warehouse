class IdContext {
	String? name;
	String? thumbnail;
	String? content;
	String? beginContext;
	String? endContext;
	String? createdAt;
	String? updatedAt;
	String? id;

	IdContext({
		this.name, 
		this.thumbnail, 
		this.content, 
		this.beginContext, 
		this.endContext, 
		this.createdAt, 
		this.updatedAt, 
		this.id, 
	});

	factory IdContext.fromJson(Map<String, dynamic> json) => IdContext(
				name: json['name'] as String?,
				thumbnail: json['thumbnail'] as String?,
				content: json['content'] as String?,
				beginContext: json['beginContext'] as String?,
				endContext: json['endContext'] as String?,
				createdAt: json['created_at'] as String?,
				updatedAt: json['updated_at'] as String?,
				id: json['id'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'name': name,
				'thumbnail': thumbnail,
				'content': content,
				'beginContext': beginContext,
				'endContext': endContext,
				'created_at': createdAt,
				'updated_at': updatedAt,
				'id': id,
			};
}
