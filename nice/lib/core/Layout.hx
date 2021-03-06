package nice.lib.core;

import haxe.Json;
import nice.lib.Collection;
import nice.lib.core.Post;

class Layout
{
    public var name : String;
    public var content : String;

    /**
     * Creates a new Layout with the given name and content.
     * @param name 
     * @param content 
     */
    public function new(name : String, content : String)
    {
        this.name = name;
        this.content = content;
    }

    /**
     * Compiles a post into HTML code.
     * @param post 
     * @param posts 
     * @param pages 
     * @param globals 
     * @return String
     */
    public function compilePost(post : Post, posts : Collection, pages : Collection, variables : Json, showDate : Bool) : String
    {
        var date = {
            day: post.getDate().getDate(),
            month: post.getDate().getMonth() + 1,   // Month ranges from 0-11, so we must add 1 to represent the current month
            year: post.getDate().getFullYear()
        };

        var context = {
            title: post.getTitle(), 
            body: post.compile(), 
            date: date, 
            posts: posts.getItems(),
            pages: pages.getItems(),
            is_post: showDate,
            variables : variables
        };

        return compile(context);
    }

    /**
     * Compiles layout using the given context
     * @param context 
     */
    public function compile(context : {}) : String
    {
        return Mustache.render(content, context);
    }
}