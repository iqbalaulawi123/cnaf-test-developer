<?php

namespace App\Controllers;

use App\Exceptions\ProcedureException;
use CodeIgniter\Controller;
use CodeIgniter\HTTP\CLIRequest;
use CodeIgniter\HTTP\IncomingRequest;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Psr\Log\LoggerInterface;
use Throwable;

/**
 * BaseController provides a convenient place for loading components
 * and performing functions that are needed by all your controllers.
 *
 * Extend this class in any new controllers:
 * ```
 *     class Home extends BaseController
 * ```
 *
 * For security, be sure to declare any new methods as protected or private.
 */
abstract class BaseController extends Controller
{
    /**
     * Be sure to declare properties for any property fetch you initialized.
     * The creation of dynamic property is deprecated in PHP 8.2.
     */

    // protected $session;

    /**
     * @param CLIRequest|IncomingRequest $request
     *
     * @return void
     */
    public function initController(RequestInterface $request, ResponseInterface $response, LoggerInterface $logger)
    {
        parent::initController($request, $response, $logger);
    }

    protected function input(): array
    {
        try {
            $data = $this->request->getJSON(true);
        } catch (Throwable $e) {
            $data = null;
        }

        if (! is_array($data)) {
            $data = $this->request->getPost() ?? [];
        }

        foreach ($data as $key => $value) {
            if (is_bool($value)) {
                $data[$key] = $value ? '1' : '0';
            } elseif (is_int($value) || is_float($value)) {
                $data[$key] = (string) $value;
            } elseif (is_string($value)) {
                $value      = trim($value);
                $data[$key] = $value === '' ? null : $value;
            }
        }

        return $data;
    }

    protected function respondSuccess($data = null, string $message = 'OK', int $code = 200): ResponseInterface
    {
        return $this->response->setStatusCode($code)->setJSON([
            'status'  => true,
            'message' => $message,
            'data'    => $data,
        ]);
    }

    protected function respondError(string $message, int $code, $data = null): ResponseInterface
    {
        return $this->response->setStatusCode($code)->setJSON([
            'status'  => false,
            'message' => $message,
            'data'    => $data,
        ]);
    }

    protected function handleException(Throwable $e): ResponseInterface
    {
        if ($e instanceof ProcedureException && $e->isConflict()) {
            return $this->respondError($e->userMessage(), 409);
        }

        log_message('error', '[{class}] {message}', ['class' => get_class($e), 'message' => $e->getMessage()]);

        return $this->respondError('Terjadi kesalahan pada server.', 500);
    }
}
