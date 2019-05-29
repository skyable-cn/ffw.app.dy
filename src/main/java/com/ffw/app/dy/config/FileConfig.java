package com.ffw.app.dy.config;

import java.io.File;

import javax.annotation.PostConstruct;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "server.file")
public class FileConfig {

	private String dir;

	public String getDir() {
		return dir;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}

	public String getDirImage() {
		return getDir() + File.separator + "image";
	}

	public String getDirPoster() {
		return getDir() + File.separator + "poster";
	}

	@PostConstruct
	public void init() {

		String tempPath = getDir() + File.separator + "image";

		File ft = new File(tempPath);
		if (!ft.exists()) {
			ft.mkdir();
		}

		tempPath = getDir() + File.separator + "poster";

		ft = new File(tempPath);
		if (!ft.exists()) {
			ft.mkdir();
		}
	}
}
