local S = core.get_translator(core.get_current_modname())

staffranks.register_rank("admin",
                        S("Administrator"),
                        "#ba0000")

staffranks.register_rank("modo",
                        S("Moderator"),
                        "#1a75ff")

staffranks.register_rank("dev",
                        S("Developer"),
                        "#0099cc")

staffranks.register_rank("build",
                        S("Builder"),
                        "#ffad33")

staffranks.register_rank("cont",
                        S("Contributor"),
                        "#a300cc")

staffranks.register_rank("vip",
                        S("VIP"),
                        "#00e600")