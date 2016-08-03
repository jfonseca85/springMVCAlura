package br.com.casadocodigo.loja.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.casadocodigo.loja.daos.ProdutoDAO;
import br.com.casadocodigo.loja.models.Produto;
import br.com.casadocodigo.loja.models.TipoPreco;
import br.com.casadocodigo.loja.validation.ProdutoValidation;

@Controller
@RequestMapping("/produtos")
public class ProdutosController {

	@Autowired
	private ProdutoDAO produtoDAO;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.addValidators(new ProdutoValidation());
	}

	@RequestMapping("/form")
	public ModelAndView form(Produto produto) {
		ModelAndView modelAndView = new ModelAndView("produtos/form");
		modelAndView.addObject("tipos", TipoPreco.values());
		return modelAndView;
	}

	@RequestMapping(method = RequestMethod.POST)
	@CacheEvict(value="produtosHome", allEntries=true)
	public ModelAndView gravar(@Valid Produto produto, BindingResult result,
			RedirectAttributes redirectAttributes) {
		System.out.println(produto);
		if (result.hasErrors()) {
			System.out.println("Valores do Produto estão errados!!!");
			return form(produto);
		}

		this.produtoDAO.grava(produto);

		ModelAndView modelAndView = new ModelAndView("redirect:produtos");
		redirectAttributes.addFlashAttribute("sucesso",
				"Produto Cadastrado com sucesso!");
		return modelAndView;
	}

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView listar() {
		List<Produto> listProdutos = produtoDAO.listar();
		ModelAndView modelAndView = new ModelAndView("produtos/lista");
		modelAndView.addObject("produtos", listProdutos);

		return modelAndView;
	}
	
	@RequestMapping("/detalhe/{id}")
	public ModelAndView detalhe(@PathVariable("id") Integer id){
	    ModelAndView modelAndView = new ModelAndView("/produtos/detalhe");
	    Produto produto = this.produtoDAO.find(id);
	    modelAndView.addObject("produto", produto);
	    return modelAndView;
	}
	
	@RequestMapping("/{id}")
	@ResponseBody
	public Produto detalheJSON(@PathVariable("id") Integer id){
	    return this.produtoDAO.find(id);
	}

}
