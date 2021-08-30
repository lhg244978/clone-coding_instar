package com.teamProject.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.teamProject.DTO.followDTO;

public interface followMapper {
	
	@Insert("insert into follow values(#{follower},#{following})")
	int following(followDTO followDTO);
	@Delete("delete from follow where follower = #{follower} and following = #{following}")
	int unFollowing(followDTO followDTO);
	
	@Select("select * from follow where follower = #{follower} and following = #{following}")
	public followDTO checkFol(followDTO followDTO);






}
