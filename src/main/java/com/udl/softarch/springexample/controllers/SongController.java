package com.udl.softarch.springexample.controllers;

import com.udl.softarch.springexample.models.Song;
import com.udl.softarch.springexample.repositories.SongRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.lang.Object;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static com.udl.softarch.springexample.repositories.SongRepository.*;

/**
 * Created by davidkaste on 16/02/15.
 */

@Controller
@RequestMapping("/songCollection/{idCollection}/")
public class SongController {

    @Autowired
    SongRepository songRepository;

    // LIST
    @RequestMapping(value = "/songs", method = RequestMethod.GET)
    @ResponseBody
    public Iterable<Song> list(@RequestParam(required = false, defaultValue = "0") int page,
                                   @RequestParam(required = false, defaultValue = "10") int size) {
        PageRequest request = new PageRequest(page, size);
        return  songRepository.findAll(request).getContent();
    }

    @RequestMapping(value = "/songs",method = RequestMethod.GET, produces = "text/html")
    public ModelAndView listHtml(@RequestParam(required = false, defaultValue = "0") int page,
                                 @RequestParam(required = false, defaultValue = "10") int size,
                                 @PathVariable("idCollection") Long idCol) {
        Map <String, Object> model = new HashMap<>();
        model.put("songs", list(page, size));
        model.put("idCollection", idCol);
        return new ModelAndView("allsongs", "map", model);
    }

    // obtener / retrieve
    @RequestMapping(value = "/songs/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Song retrieve(@PathVariable("id") Long id) {
        System.out.println(4);
        Preconditions.checkNotNull(songRepository.findOne(id), "Greeting with id %s not found", id);
        return songRepository.findOne(id);
    }

    @RequestMapping(value = "/songs/{id}", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView retrieveHTML(@PathVariable( "id" ) Long id,
                                     @PathVariable("idCollection") Long idCol) {

        Map <String, Object> model = new HashMap<>();

        Song s = retrieve(id);
        model.put("song", retrieve(id));


        model.put("idCollection", idCol);



        return new ModelAndView("songview", "map", model);
    }

    // CREATE
    @RequestMapping(value = "/songs", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    @ResponseBody
    public Song create(@Valid @RequestBody Song song, HttpServletResponse response) {
        System.out.println(2);
        Song s = songRepository.save(song);
        System.out.println(s.getId());
        return s;
    }

    @RequestMapping(value = "/songs" , method = RequestMethod.POST, consumes = "application/x-www-form-urlencoded", produces = "text/html")
    public String createHtml(@Valid @ModelAttribute("song") Song song, BindingResult binding, HttpServletResponse response) {
        if(binding.hasErrors()) {
            return "songform";
        }
        System.out.println(1);

        return "redirect:" + create(song, response).getId();
    }

    @RequestMapping(value = "/form", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView createForm(){

        Song emptysong = new Song();
        //emptyGreeting.setDate(new Date());
        return new ModelAndView("songform", "song", emptysong);
    }

    // UPDATE
    @RequestMapping(value = "/songs/{id}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Song update(@PathVariable("id") Long id, @Valid @RequestBody Song song) {
        Song oldSong = songRepository.findOne(id);
        oldSong.setBand(song.getBand());
        oldSong.setName(song.getName());
        return songRepository.save(oldSong);
    }

    @RequestMapping(value = "/songs/{id}", method = RequestMethod.PUT, consumes = "application/x-www-form-urlencoded")
    @ResponseStatus(HttpStatus.OK)
    public String updateHTML(@PathVariable("id") Long id, @Valid @ModelAttribute("song") Song song,
                             BindingResult binding) {
        if (binding.hasErrors()) {
            return "songform";
        }
        return "redirect:/songCollection/{id}/songs/" + update(id, song).getId();
    }

    // Update form
    @RequestMapping(value = "/songs/{id}/form", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView updateForm(@PathVariable("id") Long id) {
        return new ModelAndView("songform", "song", songRepository.findOne(id));
    }

    // DELETE
    @RequestMapping(value = "/songs/{id}", method = RequestMethod.DELETE)
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {
        songRepository.delete(songRepository.findOne(id));
    }

    @RequestMapping(value = "/songs/{id}", method = RequestMethod.DELETE, produces = "text/html")
    @ResponseStatus(HttpStatus.OK)
    public String deleteHTML(@PathVariable("id") Long id) {
        delete(id);
        return "redirect:/songCollection/{id}/songs";
    }
}
