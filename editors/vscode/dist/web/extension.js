/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ([
/* 0 */
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.deactivate = exports.activate = void 0;
const vscode = __webpack_require__(1);
function activate(context) {
    console.log('Signals Snippets (Dart/Flutter) extension is now active!');
    // 1. Register the skill installation command
    const installSkillsDisposable = vscode.commands.registerCommand('signals-dart.installSkills', () => __awaiter(this, void 0, void 0, function* () {
        const workspaceFolders = vscode.workspace.workspaceFolders;
        if (!workspaceFolders || workspaceFolders.length === 0) {
            vscode.window.showWarningMessage('Please open a folder or workspace first.');
            return false;
        }
        const workspaceFolder = workspaceFolders[0];
        const destUri = vscode.Uri.joinPath(workspaceFolder.uri, '.agents', 'skills');
        const srcUri = vscode.Uri.joinPath(context.extensionUri, 'skills');
        return vscode.window.withProgress({
            location: vscode.ProgressLocation.Notification,
            title: 'Signals: Installing AI Developer Skills',
            cancellable: false
        }, (progress) => __awaiter(this, void 0, void 0, function* () {
            try {
                progress.report({ message: 'Verifying extension skills...' });
                // Verify source directory exists
                try {
                    yield vscode.workspace.fs.stat(srcUri);
                }
                catch (_a) {
                    throw new Error('Skills were not found in the extension bundle. Re-installing the extension may help.');
                }
                progress.report({ message: 'Creating workspace directories...' });
                yield vscode.workspace.fs.createDirectory(vscode.Uri.joinPath(workspaceFolder.uri, '.agents'));
                progress.report({ message: 'Copying signals skills...' });
                yield vscode.workspace.fs.copy(srcUri, destUri, { overwrite: true });
                vscode.window.showInformationMessage('Successfully installed Signals AI Developer Skills to .agents/skills!');
                return true;
            }
            catch (error) {
                vscode.window.showErrorMessage(`Failed to install skills: ${(error === null || error === void 0 ? void 0 : error.message) || error}`);
                return false;
            }
        }));
    }));
    context.subscriptions.push(installSkillsDisposable);
    // 2. Register Show Documentation command
    const showDocsDisposable = vscode.commands.registerCommand('signals-dart.showDocumentation', () => {
        vscode.commands.executeCommand('workbench.view.extension.signals-sidebar');
    });
    context.subscriptions.push(showDocsDisposable);
    // 3. Register the Webview View Provider for the sidebar
    const provider = new SignalsExplorerProvider(context);
    const viewDisposable = vscode.window.registerWebviewViewProvider('signals-explorer', provider);
    context.subscriptions.push(viewDisposable);
    // 4. Startup check to proactively suggest skill installation
    checkForSkillsInstallation(context);
}
exports.activate = activate;
function deactivate() { }
exports.deactivate = deactivate;
function checkForSkillsInstallation(context) {
    return __awaiter(this, void 0, void 0, function* () {
        const workspaceFolders = vscode.workspace.workspaceFolders;
        if (!workspaceFolders || workspaceFolders.length === 0) {
            return;
        }
        const workspaceFolder = workspaceFolders[0];
        // Check if this is a Dart/Flutter project (has pubspec.yaml)
        const pubspecUri = vscode.Uri.joinPath(workspaceFolder.uri, 'pubspec.yaml');
        let isDartProject = false;
        try {
            yield vscode.workspace.fs.stat(pubspecUri);
            isDartProject = true;
        }
        catch (_a) {
            // Not a Dart project
            return;
        }
        if (!isDartProject) {
            return;
        }
        // Check if the user has opted out of reminders
        const optOutKey = `signals.optOutSkillsInstall.${workspaceFolder.uri.toString()}`;
        const isOptedOut = context.globalState.get(optOutKey, false);
        if (isOptedOut) {
            return;
        }
        // Check if .agents/skills already exists
        const skillsUri = vscode.Uri.joinPath(workspaceFolder.uri, '.agents', 'skills');
        let skillsExist = false;
        try {
            yield vscode.workspace.fs.stat(skillsUri);
            skillsExist = true;
        }
        catch (_b) {
            // Does not exist
        }
        if (skillsExist) {
            return;
        }
        // Prompt the user to install skills
        const installButton = 'Install AI Skills';
        const dontShowAgainButton = 'Don\'t Show Again';
        vscode.window.showInformationMessage('Signals AI Developer Skills are available for this workspace. Would you like to install them to .agents/skills?', installButton, dontShowAgainButton).then((selection) => __awaiter(this, void 0, void 0, function* () {
            if (selection === installButton) {
                yield vscode.commands.executeCommand('signals-dart.installSkills');
            }
            else if (selection === dontShowAgainButton) {
                yield context.globalState.update(optOutKey, true);
            }
        }));
    });
}
class SignalsExplorerProvider {
    constructor(context) {
        this.context = context;
    }
    resolveWebviewView(webviewView, _context, _token) {
        webviewView.webview.options = {
            enableScripts: true,
            localResourceRoots: [this.context.extensionUri]
        };
        webviewView.webview.html = this.getHtmlContent(webviewView.webview);
        // Handle messages from the webview
        webviewView.webview.onDidReceiveMessage((message) => __awaiter(this, void 0, void 0, function* () {
            switch (message.command) {
                case 'installSkills':
                    webviewView.webview.postMessage({ type: 'status', status: 'installing' });
                    const success = yield vscode.commands.executeCommand('signals-dart.installSkills');
                    if (success) {
                        webviewView.webview.postMessage({ type: 'status', status: 'success' });
                    }
                    else {
                        webviewView.webview.postMessage({ type: 'status', status: 'error' });
                    }
                    break;
                case 'openLink':
                    if (message.url) {
                        vscode.env.openExternal(vscode.Uri.parse(message.url));
                    }
                    break;
            }
        }));
    }
    getHtmlContent(webview) {
        return `<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Signals Explorer</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
	<style>
		:root {
			--font-primary: 'Outfit', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
			--font-mono: 'JetBrains Mono', 'Fira Code', 'Courier New', monospace;
			
			/* Brand Palette (Tailored HSL) */
			--brand-primary: hsl(150, 75%, 42%);
			--brand-primary-hover: hsl(150, 75%, 36%);
			--brand-accent: hsl(185, 80%, 45%);
			--glass-bg: rgba(255, 255, 255, 0.05);
			--glass-border: rgba(255, 255, 255, 0.08);
			--card-bg: var(--vscode-sideBar-background);
			--card-border: var(--vscode-widget-border, rgba(128, 128, 128, 0.15));
			--text-color: var(--vscode-foreground);
			--text-muted: var(--vscode-descriptionForeground);
			
			--shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
			--shadow-md: 0 8px 24px rgba(0, 0, 0, 0.25);
			
			--transition-fast: 0.2s cubic-bezier(0.16, 1, 0.3, 1);
			--transition-normal: 0.3s cubic-bezier(0.16, 1, 0.3, 1);
		}

		body {
			padding: 14px;
			font-family: var(--font-primary);
			color: var(--text-color);
			background-color: var(--vscode-sideBar-background);
			line-height: 1.5;
			margin: 0;
			overflow-x: hidden;
		}

		/* Header Section */
		.header {
			display: flex;
			flex-direction: column;
			align-items: center;
			text-align: center;
			margin-bottom: 24px;
			padding-bottom: 16px;
			border-bottom: 1px solid var(--glass-border);
		}

		.logo-container {
			position: relative;
			display: flex;
			align-items: center;
			justify-content: center;
			width: 64px;
			height: 64px;
			border-radius: 20px;
			background: linear-gradient(135deg, var(--brand-primary), var(--brand-accent));
			box-shadow: 0 8px 24px rgba(46, 213, 138, 0.3);
			margin-bottom: 12px;
			animation: pulse 3s infinite ease-in-out;
		}

		@keyframes pulse {
			0%, 100% { transform: translateY(0) scale(1); }
			50% { transform: translateY(-4px) scale(1.02); }
		}

		.logo-text {
			font-size: 26px;
			font-weight: 700;
			color: #ffffff;
			text-shadow: 0 2px 4px rgba(0,0,0,0.15);
		}

		.title {
			font-size: 20px;
			font-weight: 600;
			margin: 0;
			background: linear-gradient(90deg, var(--text-color), var(--brand-accent));
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
			letter-spacing: -0.5px;
		}

		.subtitle {
			font-size: 12px;
			color: var(--text-muted);
			margin-top: 4px;
			font-weight: 400;
		}

		/* Premium Tabs Navigation */
		.tabs {
			display: grid;
			grid-template-columns: repeat(4, 1fr);
			gap: 4px;
			background: var(--vscode-button-secondaryBackground, rgba(128,128,128,0.1));
			padding: 4px;
			border-radius: 12px;
			margin-bottom: 20px;
			border: 1px solid var(--glass-border);
		}

		.tab-btn {
			border: none;
			background: transparent;
			color: var(--text-muted);
			padding: 8px 4px;
			font-size: 11px;
			font-weight: 500;
			border-radius: 8px;
			cursor: pointer;
			transition: all var(--transition-fast);
			font-family: var(--font-primary);
			text-align: center;
		}

		.tab-btn:hover {
			color: var(--text-color);
			background: rgba(255, 255, 255, 0.03);
		}

		.tab-btn.active {
			color: #ffffff;
			background: var(--brand-primary);
			box-shadow: var(--shadow-sm);
		}

		/* Tab Content Wrapper */
		.tab-content {
			display: none;
			animation: fadeIn var(--transition-normal);
		}

		.tab-content.active {
			display: block;
		}

		@keyframes fadeIn {
			from { opacity: 0; transform: translateY(6px); }
			to { opacity: 1; transform: translateY(0); }
		}

		/* Dashboard Components */
		.hero-card {
			position: relative;
			background: linear-gradient(135deg, rgba(46, 213, 138, 0.08), rgba(0, 180, 216, 0.03));
			border: 1px solid rgba(46, 213, 138, 0.15);
			border-radius: 16px;
			padding: 16px;
			margin-bottom: 18px;
			overflow: hidden;
		}

		.hero-card::before {
			content: '';
			position: absolute;
			top: -50%;
			left: -50%;
			width: 200%;
			height: 200%;
			background: radial-gradient(circle, rgba(255,255,255,0.05) 0%, transparent 60%);
			pointer-events: none;
		}

		.hero-title {
			font-size: 14px;
			font-weight: 600;
			margin: 0 0 8px 0;
			color: var(--brand-accent);
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}

		.hero-desc {
			font-size: 12.5px;
			margin: 0 0 16px 0;
			color: var(--text-color);
			opacity: 0.9;
		}

		/* Premium Action Button */
		.btn-action {
			position: relative;
			display: inline-flex;
			align-items: center;
			justify-content: center;
			width: 100%;
			padding: 12px 16px;
			background: linear-gradient(90deg, var(--brand-primary), var(--brand-accent));
			color: #ffffff;
			border: none;
			border-radius: 12px;
			font-size: 13px;
			font-weight: 600;
			cursor: pointer;
			transition: all var(--transition-normal);
			box-shadow: 0 4px 12px rgba(46, 213, 138, 0.2);
			font-family: var(--font-primary);
			gap: 8px;
		}

		.btn-action:hover {
			transform: translateY(-2px);
			box-shadow: 0 6px 18px rgba(46, 213, 138, 0.3);
			filter: brightness(1.05);
		}

		.btn-action:active {
			transform: translateY(0);
		}

		.btn-action svg {
			width: 16px;
			height: 16px;
			fill: currentColor;
			transition: transform var(--transition-fast);
		}

		.btn-action:hover svg {
			transform: scale(1.1);
		}

		/* Status Indicator styles */
		.status-box {
			display: none;
			margin-top: 10px;
			padding: 10px 14px;
			border-radius: 8px;
			font-size: 12px;
			animation: slideDown var(--transition-fast);
		}

		@keyframes slideDown {
			from { opacity: 0; transform: translateY(-8px); }
			to { opacity: 1; transform: translateY(0); }
		}

		.status-box.installing {
			display: flex;
			background: rgba(128, 128, 128, 0.1);
			color: var(--text-color);
			border: 1px solid var(--glass-border);
		}

		.status-box.success {
			display: flex;
			background: rgba(46, 213, 138, 0.1);
			color: var(--brand-primary);
			border: 1px solid rgba(46, 213, 138, 0.2);
		}

		.status-box.error {
			display: flex;
			background: rgba(255, 75, 75, 0.1);
			color: hsl(0, 80%, 60%);
			border: 1px solid rgba(255, 75, 75, 0.2);
		}

		.loader-spinner {
			width: 14px;
			height: 14px;
			border: 2px solid var(--text-muted);
			border-top: 2px solid var(--brand-primary);
			border-radius: 50%;
			animation: spin 1s linear infinite;
			margin-right: 8px;
		}

		@keyframes spin {
			0% { transform: rotate(0deg); }
			100% { transform: rotate(360deg); }
		}

		/* Specs list */
		.specs-list {
			margin-top: 20px;
		}

		.spec-item {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 10px 12px;
			border-radius: 8px;
			background: rgba(128, 128, 128, 0.05);
			margin-bottom: 8px;
			border: 1px solid var(--glass-border);
		}

		.spec-label {
			font-size: 12px;
			color: var(--text-muted);
			font-weight: 500;
		}

		.spec-val {
			font-size: 11.5px;
			font-family: var(--font-mono);
			background: rgba(255,255,255,0.06);
			padding: 2px 6px;
			border-radius: 4px;
			color: var(--brand-accent);
		}

		/* Cheat-sheet Cards */
		.card {
			background: var(--card-bg);
			border: 1px solid var(--card-border);
			border-radius: 12px;
			padding: 12px 14px;
			margin-bottom: 12px;
			transition: all var(--transition-fast);
		}

		.card:hover {
			border-color: rgba(46, 213, 138, 0.3);
			transform: translateX(2px);
		}

		.card-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 6px;
		}

		.card-title {
			font-size: 13.5px;
			font-weight: 600;
			color: var(--brand-primary);
			margin: 0;
			font-family: var(--font-mono);
		}

		.card-tag {
			font-size: 9px;
			background: rgba(128, 128, 128, 0.15);
			padding: 1px 5px;
			border-radius: 4px;
			text-transform: uppercase;
			color: var(--text-muted);
			letter-spacing: 0.3px;
		}

		.card-desc {
			font-size: 11.5px;
			color: var(--text-color);
			opacity: 0.85;
			margin: 0 0 8px 0;
		}

		/* Fenced code block style */
		.code-block {
			background: rgba(0, 0, 0, 0.2);
			border-radius: 8px;
			padding: 8px 10px;
			overflow-x: auto;
			font-family: var(--font-mono);
			font-size: 10.5px;
			border: 1px solid var(--glass-border);
			margin: 0;
			white-space: pre;
			color: #e0e0e0;
		}

		/* Links and Docs view list */
		.doc-link-card {
			display: flex;
			align-items: center;
			justify-content: space-between;
			background: rgba(128, 128, 128, 0.04);
			border: 1px solid var(--glass-border);
			border-radius: 10px;
			padding: 10px 14px;
			margin-bottom: 8px;
			cursor: pointer;
			transition: all var(--transition-fast);
		}

		.doc-link-card:hover {
			background: rgba(46, 213, 138, 0.05);
			border-color: rgba(46, 213, 138, 0.25);
			transform: translateY(-1px);
		}

		.doc-link-info {
			display: flex;
			flex-direction: column;
		}

		.doc-link-title {
			font-size: 12.5px;
			font-weight: 500;
			color: var(--text-color);
		}

		.doc-link-desc {
			font-size: 10.5px;
			color: var(--text-muted);
			margin-top: 2px;
		}

		.doc-link-arrow {
			color: var(--brand-accent);
			font-size: 14px;
			font-weight: bold;
			transition: transform var(--transition-fast);
		}

		.doc-link-card:hover .doc-link-arrow {
			transform: translateX(3px);
		}

		.footer-text {
			text-align: center;
			font-size: 10.5px;
			color: var(--text-muted);
			margin-top: 30px;
			padding-top: 12px;
			border-top: 1px solid var(--glass-border);
		}

		.footer-text a {
			color: var(--brand-accent);
			text-decoration: none;
		}

		.footer-text a:hover {
			text-decoration: underline;
		}
	</style>
</head>
<body>
	<!-- Header -->
	<div class="header">
		<div class="logo-container">
			<span class="logo-text">S</span>
		</div>
		<h1 class="title">Signals Explorer</h1>
		<div class="subtitle">Reactive State Kit for Dart & Flutter</div>
	</div>

	<!-- Navigation Tabs -->
	<div class="tabs">
		<button class="tab-btn active" onclick="switchTab('dashboard')">Home</button>
		<button class="tab-btn" onclick="switchTab('reactivity')">Core</button>
		<button class="tab-btn" onclick="switchTab('flutter')">Flutter</button>
		<button class="tab-btn" onclick="switchTab('docs')">Docs</button>
	</div>

	<!-- TAB 1: Dashboard -->
	<div id="tab-dashboard" class="tab-content active">
		<div class="hero-card">
			<h3 class="hero-title">AI Assistant Skills</h3>
			<p class="hero-desc">Bundle repository-level developer skills in your workspace to enable AI coding assistants (like Gemini, Cursor, or Copilot) to write flawless, idiomatic reactive code.</p>
			
			<button class="btn-action" onclick="installSkills()">
				<svg viewBox="0 0 24 24">
					<path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z"/>
				</svg>
				Install AI Skills to Workspace
			</button>

			<!-- Dynamic Status -->
			<div id="install-status-installing" class="status-box installing">
				<div class="loader-spinner"></div>
				<span>Copying skills into <code>.agents/skills</code>...</span>
			</div>
			<div id="install-status-success" class="status-box success">
				<svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor" style="margin-right: 8px;"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
				<span>Skills installed! AI is ready.</span>
			</div>
			<div id="install-status-error" class="status-box error">
				<svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor" style="margin-right: 8px;"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg>
				<span>Failed to install. Check extension logs.</span>
			</div>
		</div>

		<div class="specs-list">
			<h4 style="margin: 0 0 10px 0; font-size: 13px; font-weight: 600; text-transform: uppercase; color: var(--text-muted); letter-spacing: 0.3px;">Ecosystem Details</h4>
			
			<div class="spec-item">
				<span class="spec-label">Umbrella Package</span>
				<span class="spec-val">signals v7.1.0</span>
			</div>
			<div class="spec-item">
				<span class="spec-label">Reactivity Core</span>
				<span class="spec-val">signals_core</span>
			</div>
			<div class="spec-item">
				<span class="spec-label">Flutter Support</span>
				<span class="spec-val">signals_flutter</span>
			</div>
			<div class="spec-item">
				<span class="spec-label">Developer Linting</span>
				<span class="spec-val">signals_lint</span>
			</div>
			<div class="spec-item">
				<span class="spec-label">DevTools Panel</span>
				<span class="spec-val">signals_devtools v1.1.0</span>
			</div>
		</div>
	</div>

	<!-- TAB 2: Reactivity APIs -->
	<div id="tab-reactivity" class="tab-content">
		<!-- signal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">signal</h4>
				<span class="card-tag">Primitive</span>
			</div>
			<p class="card-desc">An observable box containing a mutable value. Reading its value registers a dependency implicitly.</p>
			<pre class="code-block">final counter = signal(0, 
  options: SignalOptions(name: 'counter')
);

counter.value++; // triggers rebuilds
</pre>
		</div>
		<!-- Async Signal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Async Signal</h4>
				<span class="card-tag">Primitive</span>
			</div>
			<p class="card-desc">An async Signal Object mapping loading, data success, and error failure states cleanly.</p>
			<pre class="code-block">final data = asyncSignal(AsyncState.loading(), 
  options: AsyncSignalOptions(name: 'fetchUser')
);
</pre>
		</div>
		<!-- Computed -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Computed</h4>
				<span class="card-tag">Derived</span>
			</div>
			<p class="card-desc">Combine multiple signals into a derived, lazily-cached, read-only signal.</p>
			<pre class="code-block">final isEven = computed(() => 
  counter.value % 2 == 0,
  options: ComputedOptions(name: 'isEven')
);
</pre>
		</div>
		<!-- AsyncComputed -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">AsyncComputed</h4>
				<span class="card-tag">Derived</span>
			</div>
			<p class="card-desc">Asynchronous Computed is syntax sugar around FutureSignal for async dependent tasks.</p>
			<pre class="code-block">final apiResults = computedAsync(() => 
  fetchFromApi(searchQuery.value),
  options: AsyncSignalOptions(name: 'apiResults')
);
</pre>
		</div>
		<!-- linkedSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">linkedSignal</h4>
				<span class="card-tag">Writable Derived</span>
			</div>
			<p class="card-desc">A writable derived signal that allows manual updates and resets to a source computation on mutation.</p>
			<pre class="code-block">final email = signal('bob@email.com');
final display = linkedSignal(() => email.value);

display.value = 'custom@email.com'; // write
email.value = 'alice@email.com'; // resets display to alice
</pre>
		</div>
		<!-- ChangeStackSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">ChangeStackSignal</h4>
				<span class="card-tag">Utilities</span>
			</div>
			<p class="card-desc">Track signal values over time, exposing simple, robust undo/redo capabilities.</p>
			<pre class="code-block">final history = changeStack(0);
history.value = 1;
history.undo(); // back to 0
</pre>
		</div>
		<!-- IterableSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">IterableSignal</h4>
				<span class="card-tag">Collections</span>
			</div>
			<p class="card-desc">Iterable signals wrap collection items lazy-traversals mapped to custom reactivity layer.</p>
			<pre class="code-block">final elements = iterableSignal([1, 2, 3]);
</pre>
		</div>
		<!-- ListSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">ListSignal</h4>
				<span class="card-tag">Collections</span>
			</div>
			<p class="card-desc">Optimized list wrapper proxying standard operations to support element-level reactivity.</p>
			<pre class="code-block">final items = listSignal([1, 2]);
items.add(3); // Reacts automatically
</pre>
		</div>
		<!-- MapSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">MapSignal</h4>
				<span class="card-tag">Collections</span>
			</div>
			<p class="card-desc">Granular map wrapper supporting isolated dictionary element lookup triggers.</p>
			<pre class="code-block">final profile = mapSignal({'username': 'alice'});
profile['username'] = 'bob'; // Mutates and triggers reactives
</pre>
		</div>
		<!-- SetSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">SetSignal</h4>
				<span class="card-tag">Collections</span>
			</div>
			<p class="card-desc">Custom set wrapper ignoring duplicate entries and triggering mutations on unique inserts.</p>
			<pre class="code-block">final tags = setSignal({'flutter'});
tags.add('dart');
</pre>
		</div>
		<!-- FutureSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">FutureSignal</h4>
				<span class="card-tag">Primitive</span>
			</div>
			<p class="card-desc">Bypasses stream subscription overhead and resolves the future-evaluation loop elegantly.</p>
			<pre class="code-block">final userProfile = futureSignal(() => fetchProfile(userId.value));
</pre>
		</div>
		<!-- StreamSignal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">StreamSignal</h4>
				<span class="card-tag">Primitive</span>
			</div>
			<p class="card-desc">Dynamic, lifecycle-safe, self-disposing stream listener mapping to async loading/data/error states.</p>
			<pre class="code-block">final messages = streamSignal(() => chatSocket.messages);
</pre>
		</div>
		<!-- Signal Container (Read-only) -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Signal Container (Read-only)</h4>
				<span class="card-tag">Utilities</span>
			</div>
			<p class="card-desc">Returns a read-only parameterized caching Signal Container.</p>
			<pre class="code-block">final userContainer = readonlySignalContainer<String, User>((userId) {
  return computed(() => users.value[userId]);
});
</pre>
		</div>
		<!-- Signal Container -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Signal Container</h4>
				<span class="card-tag">Utilities</span>
			</div>
			<p class="card-desc">Returns a mutable parameterized caching Signal Container.</p>
			<pre class="code-block">final activeCounters = signalContainer<String, int>((key) {
  return signal(0);
});
</pre>
		</div>
		<!-- Value Signal -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Value Signal</h4>
				<span class="card-tag">Utilities</span>
			</div>
			<p class="card-desc">Custom Value Signal class definition template.</p>
			<pre class="code-block">class CounterSignal extends ValueSignal<int> {
  CounterSignal(super.value) : super(debugLabel: 'Counter');
}
</pre>
		</div>
	</div>

	<!-- TAB 3: Flutter Integration -->
	<div id="tab-flutter" class="tab-content">
		<!-- Watch builder -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Watch builder</h4>
				<span class="card-tag">Flutter</span>
			</div>
			<p class="card-desc">Explicit in-place Flutter Watch widget rebuilding only the returned closure closure.</p>
			<pre class="code-block">Watch.builder(
  builder: (context) => Text('Count: \${counter.value}')
)
</pre>
		</div>
		<!-- Watch -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">Watch</h4>
				<span class="card-tag">Flutter</span>
			</div>
			<p class="card-desc">Rebuilds only the wrapped closure when tracked signals change, avoiding full-widget GPU paints.</p>
			<pre class="code-block">@override
Widget build(BuildContext context) {
  return Watch((context) {
    return Text('Count: \${counter.value}');
  });
}
</pre>
		</div>
		<!-- SignalBuilder -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">SignalBuilder</h4>
				<span class="card-tag">Flutter</span>
			</div>
			<p class="card-desc">Subscribes to a single signal, rebuilding only this local builder block when it changes.</p>
			<pre class="code-block">SignalBuilder(
  builder: (context, value) {
    return Text('Value: \$value');
  },
)
</pre>
		</div>
		<!-- SignalEffect -->
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">SignalEffect</h4>
				<span class="card-tag">Flutter</span>
			</div>
			<p class="card-desc">Executes standard Flutter side effects (Snackbars, dialogs) inside widget lifecycles safely.</p>
			<pre class="code-block">SignalEffect(
  callback: (context) {
    if (error.value != null) {
      showDialog(...);
    }
  },
  child: MyContent(),
)
</pre>
		</div>
	</div>

	<!-- TAB 4: Bundled Docs -->
	<div id="tab-docs" class="tab-content">
		<h4 style="margin: 0 0 10px 0; font-size: 13px; font-weight: 600; text-transform: uppercase; color: var(--text-muted); letter-spacing: 0.3px;">Quick Guides</h4>
		
		<div class="doc-link-card" onclick="openDocLink('https://dartsignals.dev/guides/persisted-signals')">
			<div class="doc-link-info">
				<span class="doc-link-title">Persisted Signals</span>
				<span class="doc-link-desc">Local disk key-value database caching</span>
			</div>
			<span class="doc-link-arrow">→</span>
		</div>

		<div class="doc-link-card" onclick="openDocLink('https://dartsignals.dev/guides/dependency-injection')">
			<div class="doc-link-info">
				<span class="doc-link-title">Dependency Injection</span>
				<span class="doc-link-desc">Clean DI pattern with Flutter InheritedWidget</span>
			</div>
			<span class="doc-link-arrow">→</span>
		</div>

		<div class="doc-link-card" onclick="openDocLink('https://dartsignals.dev/guides/value-notifier')">
			<div class="doc-link-info">
				<span class="doc-link-title">ValueNotifier Migration</span>
				<span class="doc-link-desc">Upgrading Flutter standard states to signals</span>
			</div>
			<span class="doc-link-arrow">→</span>
		</div>

		<div class="doc-link-card" onclick="openDocLink('https://dartsignals.dev/reference/overview')">
			<div class="doc-link-info">
				<span class="doc-link-title">Migration (v6 to v7)</span>
				<span class="doc-link-desc">Updating options structures and models</span>
			</div>
			<span class="doc-link-arrow">→</span>
		</div>

		<div class="doc-link-card" onclick="openDocLink('https://dartsignals.dev/llms-full.txt')">
			<div class="doc-link-info">
				<span class="doc-link-title">Expanded llms-full.txt</span>
				<span class="doc-link-desc">Full markdown data stream for AI contexts</span>
			</div>
			<span class="doc-link-arrow">→</span>
		</div>
	</div>

	<!-- Footer -->
	<div class="footer-text">
		Signals Dart is open-source. Learn more at <a href="#" onclick="openDocLink('https://dartsignals.dev')">dartsignals.dev</a>
	</div>

	<script>
		const vscode = acquireVsCodeApi();

		function switchTab(tabId) {
			// Tab Buttons
			const buttons = document.querySelectorAll('.tab-btn');
			buttons.forEach(btn => btn.classList.remove('active'));
			
			// Find button that has onclick with tabId and set active
			const activeBtn = Array.from(buttons).find(btn => btn.getAttribute('onclick').includes(tabId));
			if (activeBtn) activeBtn.classList.add('active');

			// Tab Contents
			const contents = document.querySelectorAll('.tab-content');
			contents.forEach(content => content.classList.remove('active'));

			const activeContent = document.getElementById('tab-' + tabId);
			if (activeContent) activeContent.classList.add('active');
		}

		function installSkills() {
			resetStatus();
			vscode.postMessage({ command: 'installSkills' });
		}

		function openDocLink(url) {
			vscode.postMessage({ command: 'openLink', url: url });
		}

		function resetStatus() {
			document.getElementById('install-status-installing').style.display = 'none';
			document.getElementById('install-status-success').style.display = 'none';
			document.getElementById('install-status-error').style.display = 'none';
		}

		window.addEventListener('message', event => {
			const message = event.data;
			if (message.type === 'status') {
				resetStatus();
				if (message.status === 'installing') {
					document.getElementById('install-status-installing').style.display = 'flex';
				} else if (message.status === 'success') {
					document.getElementById('install-status-success').style.display = 'flex';
				} else if (message.status === 'error') {
					document.getElementById('install-status-error').style.display = 'flex';
				}
			}
		});
	</script>
</body>
</html>
`;
    }
}


/***/ }),
/* 1 */
/***/ ((module) => {

module.exports = require("vscode");

/***/ })
/******/ 	]);
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module is referenced by other modules so it can't be inlined
/******/ 	var __webpack_exports__ = __webpack_require__(0);
/******/ 	var __webpack_export_target__ = exports;
/******/ 	for(var i in __webpack_exports__) __webpack_export_target__[i] = __webpack_exports__[i];
/******/ 	if(__webpack_exports__.__esModule) Object.defineProperty(__webpack_export_target__, "__esModule", { value: true });
/******/ 	
/******/ })()
;
//# sourceMappingURL=extension.js.map