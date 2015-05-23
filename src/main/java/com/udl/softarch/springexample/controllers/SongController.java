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
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.*;
import java.lang.Object;
import java.lang.reflect.Array;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

import static com.udl.softarch.springexample.repositories.SongRepository.*;

/**
 * Created by davidkaste on 16/02/15.
 */

@Controller
@RequestMapping("/songCollection/{idCollection}/")
public class SongController {

    @Autowired
    SongRepository songRepository;


    @RequestMapping(value = "/songs/search", method = RequestMethod.GET)  //? get parameters from query?
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Iterable<String> listArtistsBySong(@RequestParam(value ="song" , required = true)String song
    ) throws MalformedURLException {
        ArrayList<String> bandList = new ArrayList<String>();
        String s = "https://musicbrainz.org/ws/2/recording/?query=";
        StringTokenizer st = new StringTokenizer(song);
        String aux = new String();
        while(st.hasMoreTokens()){
             aux = aux+st.nextToken()+"%20";
        }
        s = s  +aux;
        URL url = new URL(s);

        DocumentBuilderFactory doc = DocumentBuilderFactory.newInstance();
        try {
            DocumentBuilder db = doc.newDocumentBuilder();
            Document document = db.parse(url.openStream());
            document.getDocumentElement().normalize();
            NodeList recordingList = document.getElementsByTagName("recording");

            for (int temp = 0; temp < recordingList.getLength(); temp++) {
                Node nNode = recordingList.item(temp);
                Element e = (Element) nNode;
                NodeList artistList = e.getElementsByTagName("artist");
                Node artist = artistList.item(0);
                e = (Element) artist;
                NodeList nameList = e.getElementsByTagName("name");
                Node artistName = nameList.item(0);
                bandList.add(artistName.getTextContent().toString());
            }

            return bandList;


        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    @RequestMapping(value = "/songs/search", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView listArtistsBySongHTML(  @RequestParam(value ="name" , required = true)String song,
                                                @PathVariable("idCollection") Long idCol)throws Exception {
        Map <String, Object> model = new HashMap<>();
        model.put("bands", listArtistsBySong(song));
        model.put("song", song);
        model.put("idCollection", idCol);
        return new ModelAndView("searchResult", "map", model);
    }

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
    @RequestMapping(value = "/songs", method = RequestMethod.POST )
    @ResponseStatus(HttpStatus.CREATED)
    @ResponseBody
    public Song create(@Valid @RequestBody Song song, HttpServletResponse response) {
        Song s = songRepository.save(song);
        System.out.println("produces data");

        return s;
    }

    @RequestMapping(value = "/songs" , method = RequestMethod.POST , consumes = "application/x-www-form-urlencoded", produces = "text/html")
    public String createHtml(@Valid @ModelAttribute("song") Song song, BindingResult binding, HttpServletResponse response,
                             @PathVariable("idCollection") Long idCol) {
        System.out.println("produces html");
        if(binding.hasErrors()) {
            System.out.println("meeeeu");
            return "redirect:/songCollection/"+idCol+"/songs/form";
        }

        Long id = create(song, response).getId();
        return "redirect:/songCollection/"+idCol+"/songs/"+id;

        //return "heloo baby";
    }

    @RequestMapping(value = "/songs/form", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView createForm(){

        Song emptysong = new Song();
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
    public String updateHTML(@PathVariable("id") Long id,
                             @Valid @ModelAttribute("song") Song song,
                             @PathVariable("idCollection")Long idCol,
                             BindingResult binding) {
        if (binding.hasErrors()) {
            return "redirect:/songCollection/"+idCol+"/songs/"+id+"/form";
        }
        return "redirect:/songCollection/"+idCol+"/songs/" + update(id, song).getId();
    }

    // Update form
    @RequestMapping(value = "/songs/{id}/form", method = RequestMethod.GET, produces = "text/html")
    public ModelAndView updateForm(@PathVariable("id") Long id, @PathVariable("idCollection") Long idCol) {
        Map <String, Object> model = new HashMap<>();
       
        model.put("song", songRepository.findOne(id));
        model.put("idCollection", idCol);

        return new ModelAndView("PutSongForm", "map", model);
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
