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
@RequestMapping("/songCollection/{idCollection}/songs")
public class SongController {

    @Autowired
    SongRepository songRepository;

    // LIST
    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public Iterable<Song> list(@RequestParam(required = false, defaultValue = "0") int page,
                                   @RequestParam(required = false, defaultValue = "10") int size) {
        PageRequest request = new PageRequest(page, size);
        return  songRepository.findAll(request).getContent();
    }

    @RequestMapping(method = RequestMethod.GET, produces = "text/html")
    public ModelAndView listHtml(@RequestParam(required = false, defaultValue = "0") int page,
                                 @RequestParam(required = false, defaultValue = "10") int size,
                                 @PathVariable("idCollection") Long idCol) {
        Map <String, Object> model = new HashMap<>();
        model.put("songs", list(page, size));
        model.put("idCollection", idCol);
        return new ModelAndView("allsongs", "map", model);
    }

    // obtener / retrieve
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Song retrieve(@PathVariable("id") Long id) {
        Preconditions.checkNotNull(songRepository.findOne(id), "Greeting with id %s not found", id);
        return songRepository.findOne(id);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView retrieveHTML(@PathVariable( "id" ) Long id) {
        return new ModelAndView("songview", "song", retrieve(id));
    }

    // CREATE
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    @ResponseBody
    public Song create(@Valid @RequestBody Song song, HttpServletResponse response) {
        return songRepository.save(song);
    }

    @RequestMapping(method = RequestMethod.POST, consumes = "application/x-www-form-urlencoded", produces = "text/html")
    public String createHtml(@Valid @ModelAttribute("song") Song song, BindingResult binding, HttpServletResponse response) {
        if(binding.hasErrors()) {
            return "songform";
        }
        return "redirect:/songCollection/{id}/songs/" + create(song, response).getId();
    }

    @RequestMapping(value = "/form", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView createForm(@PathVariable("idCollection") Long idCol){

        Song emptysong = new Song();
        //emptyGreeting.setDate(new Date());
        return new ModelAndView("songform", "song", emptysong);
    }

    // UPDATE
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Song update(@PathVariable("id") Long id, @Valid @RequestBody Song song) {
        Song oldSong = songRepository.findOne(id);
        oldSong.setBand(song.getBand());
        oldSong.setName(song.getName());
        return songRepository.save(oldSong);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = "application/x-www-form-urlencoded")
    @ResponseStatus(HttpStatus.OK)
    public String updateHTML(@PathVariable("id") Long id, @Valid @ModelAttribute("song") Song song,
                             BindingResult binding) {
        if (binding.hasErrors()) {
            return "songform";
        }
        return "redirect:/songCollection/{id}/songs/" + update(id, song).getId();
    }

    // Update form
    @RequestMapping(value = "/{id}/form", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView updateForm(@PathVariable("id") Long id) {
        return new ModelAndView("songform", "song", songRepository.findOne(id));
    }

    // DELETE
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {
        songRepository.delete(songRepository.findOne(id));
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    @ResponseStatus(HttpStatus.OK)
    public String deleteHTML(@PathVariable("id") Long id) {
        delete(id);
        return "redirect:/songCollection/{id}/songs";
    }
}
