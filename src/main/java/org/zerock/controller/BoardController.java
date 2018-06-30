<<<<<<< HEAD
package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void registGet(BoardVO board, Model model) throws Exception{
		logger.info("register get...");
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registPost(BoardVO board, RedirectAttributes rttr) throws Exception{
		logger.info("register post...");
		logger.info(board.toString());
		
		service.regist(board);
		
		rttr.addAttribute("result", "success");
		
		//return "/board/success"; 새로 고침 insert 문제 발생으로 redirect 처리
		return "redirect:/board/listAll"; 
	}
	
	@RequestMapping(value="/listAll", method=RequestMethod.GET)
	public void listAll(Model model) throws Exception{
		logger.info("show all list...................");
		model.addAttribute("list", service.listAll());
	}
	
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, Model model) throws Exception{
		//이름없이 데이터를 넣으면 자동으로 클래의 이름을 소문자로 시작해서 사용하게 됨 즉, boardVO로 사용
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		rttr.addAttribute("msg", "success");
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGET(int bno, Model model) throws Exception{
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modefyPOST(BoardVO board, RedirectAttributes rttr) throws Exception{
		logger.info("mod post.........");
		service.modify(board);
		rttr.addAttribute("msg", "success");
		
		return "redirect:/board/listAll";
	}
	
}
=======
package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void registGet(BoardVO board, Model model) throws Exception{
		logger.info("register get...");
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registPost(BoardVO board, RedirectAttributes rttr) throws Exception{
		logger.info("register post...");
		logger.info(board.toString());
		
		service.regist(board);
		
		rttr.addAttribute("result", "success");
		
		//return "/board/success"; 새로 고침 insert 문제 발생으로 redirect 처리
		return "redirect:/board/listAll"; 
	}
	
	@RequestMapping(value="/listAll", method=RequestMethod.GET)
	public void listAll(Model model) throws Exception{
		logger.info("show all list...................");
		model.addAttribute("list", service.listAll());
	}
	
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, Model model) throws Exception{
		//이름없이 데이터를 넣으면 자동으로 클래의 이름을 소문자로 시작해서 사용하게 됨 즉, boardVO로 사용
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		rttr.addAttribute("msg", "success");
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGET(int bno, Model model) throws Exception{
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modefyPOST(BoardVO board, RedirectAttributes rttr) throws Exception{
		logger.info("mod post.........");
		service.modify(board);
		rttr.addAttribute("msg", "success");
		
		//Git push TEST,.
		return "redirect:/board/listAll";
	}
	
}
>>>>>>> e0b83ef4691577ae9e0f52df3077b2215482ded1
