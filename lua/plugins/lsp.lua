return {
	"neovim/nvim-lspconfig",
	event = "User FilePost",
	dependencies = { "nvim-cmp" },
	config = function()
		local root_dir = vim.fn.getcwd()
		local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			vim.lsp.config("*", { capabilities = cmp_lsp.default_capabilities() })
		end

		local function get_vue_plugin_path()
			if require("nixCatsUtils").isNixCats then
				local exe = vim.fn.exepath("vue-language-server")
				if exe ~= "" then
					return vim.fn.glob(vim.fs.dirname(exe) .. "/../lib/**/@vue/typescript-plugin", true, true)[1]
				end
			end
			return vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
		end

		local function get_typescript_sdk_path()
			if require("nixCatsUtils").isNixCats then
				local exe = vim.fn.exepath("tsserver")
				if exe ~= "" then
					return vim.fn.glob(vim.fs.dirname(exe) .. "/../lib/node_modules/typescript/lib", true, true)[1]
				end
			end
			return vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
		end

		local function setup_servers()
			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = get_vue_plugin_path() or "",
				languages = { "vue" },
				configNamespace = "typescript",
			}

			local servers = {
				cssls = {},
				vue_ls = {},
				cmake = {},
				bashls = {},
				marksman = {},
				jsonls = {},
				pyright = {},
				luau_lsp = {
					cmd = {
						"luau-lsp",
						"lsp",
						"--definitions:@noctalia=" .. root_dir .. "/noctalia.d.luau",
					},
					settings = {
						["luau-lsp"] = {
							ignoreGlobs = { "**/*.d.luau" },
							platform = {
								type = "standard",
							},
							sourcemap = {
								enabled = false,
							},
						},
					},
				},
				svelte = {
					init_options = {
						typescript = {
							tsdk = get_typescript_sdk_path(),
						},
					},
				},
				jdtls = {},
				templ = {},

				astro = {
					init_options = {
						typescript = {
							tsdk = get_typescript_sdk_path(),
						},
					},
				},

				html = {
					filetypes = { "html", "ejs" },
				},

				emmet_ls = {
					filetypes = { "html", "javascript", "markdown" },
				},

				vtsls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
					root_markers = {
						"tsconfig.json",
						"package.json",
						"jsconfig.json",
						".git",
						".envrc",
					},
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = { vue_plugin },
							},
						},
					},
				},

				intelephense = {
					settings = {
						intelephense = {
							stubs = {
								"apache",
								"bcmath",
								"bz2",
								"calendar",
								"com_dotnet",
								"Core",
								"ctype",
								"curl",
								"date",
								"dba",
								"dom",
								"enchant",
								"exif",
								"FFI",
								"fileinfo",
								"filter",
								"fpm",
								"ftp",
								"gd",
								"gettext",
								"gmp",
								"hash",
								"iconv",
								"imap",
								"intl",
								"json",
								"ldap",
								"libxml",
								"mbstring",
								"meta",
								"mysqli",
								"oci8",
								"odbc",
								"openssl",
								"pcntl",
								"pcre",
								"PDO",
								"pdo_ibm",
								"pdo_mysql",
								"pdo_pgsql",
								"pdo_sqlite",
								"pgsql",
								"Phar",
								"posix",
								"pspell",
								"readline",
								"Reflection",
								"session",
								"shmop",
								"SimpleXML",
								"snmp",
								"soap",
								"sockets",
								"sodium",
								"SPL",
								"sqlite3",
								"standard",
								"superglobals",
								"sysvmsg",
								"sysvsem",
								"sysvshm",
								"tidy",
								"tokenizer",
								"xml",
								"xmlreader",
								"xmlrpc",
								"xmlwriter",
								"xsl",
								"Zend OPcache",
								"zip",
								"zlib",
								"wordpress",
								"laravel",
								"blade",
							},
						},
					},
				},

				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},

				nixd = {
					on_attach = function(client)
						client.server_capabilities.codeActionProvider = nil
						client.server_capabilities.definitionProvider = false
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentSymbolProvider = false
						client.server_capabilities.documentHighlightProvider = false
						client.server_capabilities.hoverProvider = false
						client.server_capabilities.inlayHintProvider = false
						client.server_capabilities.referencesProvider = false
						client.server_capabilities.renameProvider = false
					end,
				},

				["nil"] = {
					on_attach = function(client)
						client.server_capabilities.completionProvider = nil
					end,
					cmd = { vim.fn.exepath("nil") },
					filetypes = { "nix" },
				},

				lua_ls = {
					filetypes = { "lua" },
					settings = {
						Lua = {
							hint = {
								enable = true,
							},
							diagnostics = {
								globals = {
									"vim",
									"require",
									"Snacks",
									"Laravel",
									"state",
								},
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},

				roslyn = {
					settings = {
						["csharp|inlay_hints"] = {
							csharp_enable_inlay_hints_for_implicit_object_creation = true,
							csharp_enable_inlay_hints_for_implicit_variable_types = true,
						},
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = true,
						},
					},
				},

				qmlls = {
					handlers = {
						["textDocument/publishDiagnostics"] = function(err, method, params, client_id)
							local filtered_diagnostics = {}
							for _, diagnostic in ipairs(method.diagnostics) do
								if diagnostic.severity ~= vim.diagnostic.severity.WARN then
									table.insert(filtered_diagnostics, diagnostic)
								end
							end

							method.diagnostics = filtered_diagnostics
							vim.lsp.handlers["textDocument/publishDiagnostics"](err, method, params, client_id)
						end,
					},
				},

				dartls = {
					cmd = { "dart", "language-server", "--protocol=lsp" },
				},
			}

			vim.api.nvim_create_autocmd("User", {
				pattern = "DirenvLoaded",
				callback = function()
					vim.cmd("silent! lsp restart")
				end,
			})

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end

		setup_servers()
	end,
}
